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
  final _nameController = TextEditingController();
  final _specialtyController = TextEditingController();
  final _imageUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DoctorsManagementBloc>().add(LoadDoctors());
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _specialtyController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DoctorsManagementBloc, DoctorsManagementState>(
      listener: (context, state) {
        if (state is DoctorsLoaded) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Список врачей обновлен'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Управление врачами'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
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
            return Center(child: CircularProgressIndicator());
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showAddDoctorDialog(context),
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildDoctorsList(List<Doctor> doctors) {
    if (doctors.isEmpty) {
      return Center(
        child: Text(
          'Нет врачей в системе',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: doctors.length,
      itemBuilder: (context, index) {
        return _buildDoctorCard(doctors[index]);
      },
    );
  }

  Widget _buildDoctorCard(Doctor doctor) {
    return Card(
      key: ValueKey(doctor.name),
      margin: EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(doctor.imageUrl),
              backgroundColor: Colors.grey[300],
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor.name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    doctor.specialty,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.edit, color: Colors.blue),
              onPressed: () => _showEditDoctorDialog(context, doctor),
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => _showDeleteConfirmation(context, doctor.name),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddDoctorDialog(BuildContext context) {
    _nameController.clear();
    _specialtyController.clear();
    _imageUrlController.clear();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Добавить врача'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'ФИО врача'),
              ),
              TextField(
                controller: _specialtyController,
                decoration: InputDecoration(labelText: 'Специальность'),
              ),
              TextField(
                controller: _imageUrlController,
                decoration: InputDecoration(labelText: 'URL фото'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_nameController.text.isNotEmpty &&
                  _specialtyController.text.isNotEmpty) {
                final newDoctor = Doctor(
                  name: _nameController.text,
                  specialty: _specialtyController.text,
                  imageUrl: _imageUrlController.text.isNotEmpty
                      ? _imageUrlController.text
                      : 'https://via.placeholder.com/150',
                );
                context.read<DoctorsManagementBloc>().add(AddDoctor(newDoctor));
                Navigator.of(context).pop();
              }
            },
            child: Text('Добавить'),
          ),
        ],
      ),
    );
  }

  void _showEditDoctorDialog(BuildContext context, Doctor doctor) {
    _nameController.text = doctor.name;
    _specialtyController.text = doctor.specialty;
    _imageUrlController.text = doctor.imageUrl;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Редактировать врача'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'ФИО врача'),
              ),
              TextField(
                controller: _specialtyController,
                decoration: InputDecoration(labelText: 'Специальность'),
              ),
              TextField(
                controller: _imageUrlController,
                decoration: InputDecoration(labelText: 'URL фото'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_nameController.text.isNotEmpty &&
                  _specialtyController.text.isNotEmpty) {
                final updatedDoctor = Doctor(
                  name: _nameController.text,
                  specialty: _specialtyController.text,
                  imageUrl: _imageUrlController.text.isNotEmpty
                      ? _imageUrlController.text
                      : doctor.imageUrl,
                );
                context.read<DoctorsManagementBloc>().add(
                    UpdateDoctor(oldDoctor: doctor, newDoctor: updatedDoctor)
                );
                Navigator.of(context).pop();
              }
            },
            child: Text('Сохранить'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, String doctorName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Удалить врача'),
        content: Text('Вы уверены, что хотите удалить врача $doctorName?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              context.read<DoctorsManagementBloc>().add(DeleteDoctor(doctorName));
              Navigator.of(context).pop();
            },
            child: Text('Удалить', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}