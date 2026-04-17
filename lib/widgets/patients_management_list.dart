import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:first_flutter_project/bloc/patients_management/patients_management_bloc.dart';
import 'package:first_flutter_project/models/patient.dart';

class PatientsManagementList extends StatefulWidget {
  const PatientsManagementList({super.key});

  @override
  State<PatientsManagementList> createState() => _PatientsManagementListState();
}

class _PatientsManagementListState extends State<PatientsManagementList> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PatientsManagementBloc>().add(LoadPatients());
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _middleNameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PatientsManagementBloc, PatientsManagementState>(
      builder: (context, state) {
        if (state is PatientsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PatientsLoaded) {
          return _buildPatientsList(state.patients);
        } else if (state is PatientsError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildPatientsList(List<Patient> patients) {
    if (patients.isEmpty) {
      return const Center(
        child: Text(
          'Нет пациентов в системе',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: patients.length,
      itemBuilder: (context, index) {
        return _buildPatientCard(patients[index]);
      },
    );
  }

  Widget _buildPatientCard(Patient patient) {
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
                    patient.fullName,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  if (patient.username != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      'Логин: ${patient.username}',
                      style: const TextStyle(fontSize: 14, color: Colors.blue),
                    ),
                  ],
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () => _showEditPatientDialog(context, patient),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _showDeleteConfirmation(context, patient),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditPatientDialog(BuildContext context, Patient patient) {
    _firstNameController.text = patient.firstName;
    _lastNameController.text = patient.lastName;
    _middleNameController.text = patient.middleName ?? "";
    _usernameController.text = patient.username ?? "";
    _passwordController.clear();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Редактировать пациента'),
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
                  _usernameController.text.isNotEmpty) {
                final updatedPatient = Patient(
                  id: patient.id,
                  firstName: _firstNameController.text,
                  lastName: _lastNameController.text,
                  middleName: _middleNameController.text.isEmpty ? null : _middleNameController.text,
                  username: _usernameController.text,
                  password: _passwordController.text.isEmpty ? null : _passwordController.text,
                );
                context.read<PatientsManagementBloc>().add(UpdatePatient(updatedPatient));
                Navigator.of(context).pop();
              }
            },
            child: const Text('Сохранить'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, Patient patient) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Удаление пациента'),
        content: Text('Вы уверены, что хотите удалить пациента ${patient.fullName}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              context.read<PatientsManagementBloc>().add(DeletePatient(patient.id!));
              Navigator.of(context).pop();
            },
            child: const Text('Удалить', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
