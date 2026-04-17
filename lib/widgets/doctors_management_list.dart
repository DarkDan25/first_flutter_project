import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:first_flutter_project/bloc/doctors_management/doctors_management_bloc.dart';
import 'package:first_flutter_project/models/doctor.dart';

class DoctorsManagementList extends StatefulWidget {
  const DoctorsManagementList({super.key});

  @override
  State<DoctorsManagementList> createState() => _DoctorsManagementListState();
}

class _DoctorsManagementListState extends State<DoctorsManagementList> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _specialtyController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

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
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorsManagementBloc, DoctorsManagementState>(
      builder: (context, state) {
        if (state is DoctorsLoaded) {
          return _buildDoctorsList(state.doctors);
        }
        return const Center(child: CircularProgressIndicator());
      },
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
                  if (doctor.username != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      'Логин: ${doctor.username}',
                      style: const TextStyle(fontSize: 12, color: Colors.blue),
                    ),
                  ],
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

  void _showEditDoctorDialog(BuildContext context, Doctor doctor) {
    _firstNameController.text = doctor.firstName;
    _lastNameController.text = doctor.lastName;
    _middleNameController.text = doctor.middleName ?? "";
    _specialtyController.text = doctor.specialty;
    _usernameController.text = doctor.username ?? "";
    _passwordController.clear();

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
              const Divider(height: 32),
              const Text('Учетные данные', style: TextStyle(fontWeight: FontWeight.bold)),
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Логин'),
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Новый пароль (оставьте пустым, если не хотите менять)'),
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
                  _specialtyController.text.isNotEmpty &&
                  _usernameController.text.isNotEmpty) {
                final updatedDoctor = Doctor(
                  id: doctor.id,
                  firstName: _firstNameController.text,
                  lastName: _lastNameController.text,
                  middleName: _middleNameController.text.isEmpty ? null : _middleNameController.text,
                  specialty: _specialtyController.text,
                  username: _usernameController.text,
                  password: _passwordController.text.isEmpty ? null : _passwordController.text,
                );
                context.read<DoctorsManagementBloc>().add(UpdateDoctor(updatedDoctor));
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
        title: const Text('Удаление врача'),
        content: Text('Вы уверены, что хотите удалить врача ${doctor.fullName}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              context.read<DoctorsManagementBloc>().add(DeleteDoctor(doctor.id!));
              Navigator.of(context).pop();
            },
            child: const Text('Удалить', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
