import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:first_flutter_project/bloc/login/login_bloc.dart';
import 'package:first_flutter_project/bloc/current_appointments/current_appointments_bloc.dart';
import 'package:first_flutter_project/bloc/history/history_bloc.dart';
import 'package:first_flutter_project/bloc/make_appointment/make_appointment_bloc.dart';
import 'package:first_flutter_project/screens/current_appointments_screen.dart';
import 'package:first_flutter_project/widgets/doctors_management_list.dart';
import 'package:first_flutter_project/widgets/patients_management_list.dart';
import 'package:first_flutter_project/bloc/doctors_management/doctors_management_bloc.dart';
import 'package:first_flutter_project/models/doctor.dart';

import '../bloc/patients_management/patients_management_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showDoctors = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _reloadData();
    });
  }

  void _reloadData() {
    final loginState = context.read<LoginBloc>().state;
    if (loginState is LoginSuccess) {
      if (loginState.role == 'PATIENT' || loginState.role == 'DOCTOR') {
        context.read<CurrentAppointmentsBloc>().add(LoadCurrentAppointments());
        context.read<HistoryBloc>().add(LoadHistory());
      } else if (loginState.role == 'ADMIN') {
        context.read<DoctorsManagementBloc>().add(LoadDoctors());
        context.read<PatientsManagementBloc>().add(LoadPatients());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state is LoginSuccess) {
          final role = state.role;
          return Scaffold(
            appBar: AppBar(
              title: Text(role == 'ADMIN' ? 'Управление клиникой' : 'Текущие записи'),
              actions: [
                if (role == 'PATIENT')
                  IconButton(
                    icon: Icon(Icons.info),
                    onPressed: () => context.push('/clinic_info'),
                  ),
                IconButton(
                  icon: Icon(Icons.person),
                  onPressed: () => context.push('/profile'),
                ),
              ],
            ),
            body: _buildBody(role),
            floatingActionButton: _buildFab(role),
          );
        }
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget _buildBody(String role) {
    if (role == 'ADMIN') {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => setState(() => _showDoctors = true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _showDoctors ? Colors.blue : Colors.grey[300],
                      foregroundColor: _showDoctors ? Colors.white : Colors.black,
                    ),
                    child: Text('Врачи'),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => setState(() => _showDoctors = false),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: !_showDoctors ? Colors.blue : Colors.grey[300],
                      foregroundColor: !_showDoctors ? Colors.white : Colors.black,
                    ),
                    child: Text('Пациенты'),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _showDoctors ? DoctorsManagementList() : PatientsManagementList(),
          ),
        ],
      );
    } else {
      // Patients and Doctors view current appointments
      return BlocBuilder<CurrentAppointmentsBloc, CurrentAppointmentsState>(
        builder: (context, state) {
          if (state is CurrentAppointmentsLoaded) {
            return CurrentAppointmentsScreen(
              appointments: state.appointments,
              role: role,
              onCancelAppointment: (id) => context.read<CurrentAppointmentsBloc>().add(CancelAppointment(id)),
              onCompleteAppointment: (id) {
                final appt = state.appointments.firstWhere((a) => a.id == id);
                context.read<CurrentAppointmentsBloc>().add(CompleteAppointment(id));
                context.read<HistoryBloc>().add(AddToHistory(appt));
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      );
    }
  }

  Widget? _buildFab(String role) {
    if (role == 'ADMIN') {
      if (_showDoctors) {
        return FloatingActionButton(
          onPressed: () => _showAddDoctorDialog(context),
          child: Icon(Icons.add),
          tooltip: 'Добавить врача',
        );
      }
      return null; // For patients we don't have add button yet as they register themselves
    } else if (role == 'PATIENT') {
      return FloatingActionButton(
        onPressed: () => context.push('/make'),
        child: Icon(Icons.add),
        tooltip: 'Записаться к врачу',
      );
    }
    return null;
  }

  // Reuse dialog logic from DoctorsManagementScreen if needed, or keep it simple
  void _showAddDoctorDialog(BuildContext context) {
    final _firstNameController = TextEditingController();
    final _lastNameController = TextEditingController();
    final _middleNameController = TextEditingController();
    final _specialtyController = TextEditingController();
    final _usernameController = TextEditingController();
    final _passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Добавить врача'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: _lastNameController, decoration: const InputDecoration(labelText: 'Фамилия')),
              TextField(controller: _firstNameController, decoration: const InputDecoration(labelText: 'Имя')),
              TextField(controller: _middleNameController, decoration: const InputDecoration(labelText: 'Отчество')),
              TextField(controller: _specialtyController, decoration: const InputDecoration(labelText: 'Специальность')),
              const Divider(height: 32),
              TextField(controller: _usernameController, decoration: const InputDecoration(labelText: 'Логин')),
              TextField(controller: _passwordController, obscureText: true, decoration: const InputDecoration(labelText: 'Пароль')),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Отмена')),
          ElevatedButton(
            onPressed: () {
              if (_firstNameController.text.isNotEmpty && _lastNameController.text.isNotEmpty && _usernameController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
                final doctor = Doctor(
                  firstName: _firstNameController.text,
                  lastName: _lastNameController.text,
                  middleName: _middleNameController.text.isEmpty ? null : _middleNameController.text,
                  specialty: _specialtyController.text,
                  username: _usernameController.text,
                  password: _passwordController.text,
                );
                context.read<DoctorsManagementBloc>().add(AddDoctor(doctor));
                Navigator.pop(context);
              }
            },
            child: const Text('Добавить'),
          ),
        ],
      ),
    );
  }
}
