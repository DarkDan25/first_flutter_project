import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:first_flutter_project/bloc/doctors_management/doctors_management_bloc.dart';
import 'package:first_flutter_project/models/doctor.dart';

class DoctorsManagementScreen extends StatefulWidget {
  const DoctorsManagementScreen({super.key});

  @override
  State<DoctorsManagementScreen> createState() => _DoctorsManagementScreenState();
}

class _DoctorsManagementScreenState extends State<DoctorsManagementScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _specialtyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DoctorsManagementBloc>().add(LoadDoctors());
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _middleNameController.dispose();
    _specialtyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DoctorsManagementBloc, DoctorsManagementState>(
      listener: (context, state) {
        if (state is DoctorsLoaded) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Список врачей обновлен'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Управление врачами'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: BlocBuilder<DoctorsManagementBloc, DoctorsManagementState>(
          buildWhen: (previous, current) {
            return current is DoctorsLoaded;
          },
          builder: (context, state) {
            if (state is DoctorsLoaded) {
              return _buildDoctorsList(state.doctors);
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showAddDoctorDialog(context),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildDoctorsList(List<Doctor> doctors) {
    if (doctors.isEmpty) {
      return const Center(
        child: Text(
          'Нет врачей в системе',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: doctors.length,
      itemBuilder: (context, index) {
        return _buildDoctorCard(doctors[index]);
      },
    );
  }

  Widget _buildDoctorCard(Doctor doctor) {
    return Card(
      key: ValueKey(doctor.id),
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor.fullName,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    doctor.specialty,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () => _showEditDoctorDialog(context, doctor),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _showDeleteConfirmation(context, doctor),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddDoctorDialog(BuildContext context) {
    _firstNameController.clear();
    _lastNameController.clear();
    _middleNameController.clear();
    _specialtyController.clear();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Добавить врача'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _lastNameController,
                decoration: const InputDecoration(labelText: 'Фамилия'),
              ),
              TextField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: 'Имя'),
              ),
              TextField(
                controller: _middleNameController,
                decoration: const InputDecoration(labelText: 'Отчество (опционально)'),
              ),
              TextField(
                controller: _specialtyController,
                decoration: const InputDecoration(labelText: 'Специальность'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_firstNameController.text.isNotEmpty &&
                  _lastNameController.text.isNotEmpty &&
                  _specialtyController.text.isNotEmpty) {
                final newDoctor = Doctor(
                  firstName: _firstNameController.text,
                  lastName: _lastNameController.text,
                  middleName: _middleNameController.text.isEmpty ? null : _middleNameController.text,
                  specialty: _specialtyController.text,
                );
                context.read<DoctorsManagementBloc>().add(AddDoctor(newDoctor));
                Navigator.of(context).pop();
              }
            },
            child: const Text('Добавить'),
          ),
        ],
      ),
    );
  }

  void _showEditDoctorDialog(BuildContext context, Doctor doctor) {
    _firstNameController.text = doctor.firstName;
    _lastNameController.text = doctor.lastName;
    _middleNameController.text = doctor.middleName ?? "";
    _specialtyController.text = doctor.specialty;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Редактировать врача'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _lastNameController,
                decoration: const InputDecoration(labelText: 'Фамилия'),
              ),
              TextField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: 'Имя'),
              ),
              TextField(
                controller: _middleNameController,
                decoration: const InputDecoration(labelText: 'Отчество (опционально)'),
              ),
              TextField(
                controller: _specialtyController,
                decoration: const InputDecoration(labelText: 'Специальность'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_firstNameController.text.isNotEmpty &&
                  _lastNameController.text.isNotEmpty &&
                  _specialtyController.text.isNotEmpty) {
                final updatedDoctor = Doctor(
                  id: doctor.id,
                  firstName: _firstNameController.text,
                  lastName: _lastNameController.text,
                  middleName: _middleNameController.text.isEmpty ? null : _middleNameController.text,
                  specialty: _specialtyController.text,
                );
                context.read<DoctorsManagementBloc>().add(
                    UpdateDoctor(oldDoctor: doctor, newDoctor: updatedDoctor)
                );
                Navigator.of(context).pop();
              }
            },
            child: const Text('Сохранить'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, Doctor doctor) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Удалить врача'),
        content: Text('Вы уверены, что хотите удалить врача ${doctor.fullName}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              if (doctor.id != null) {
                context.read<DoctorsManagementBloc>().add(DeleteDoctor(doctor.id!));
              }
              Navigator.of(context).pop();
            },
            child: const Text('Удалить', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
