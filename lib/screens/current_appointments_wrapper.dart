import 'package:flutter/material.dart';
import 'package:first_flutter_project/screens/current_appointments_screen.dart';
import 'package:first_flutter_project/screens/make_appointment_screen.dart';
import 'package:first_flutter_project/screens/profile_screen.dart';
import 'package:first_flutter_project/models/appointment.dart';
import 'package:go_router/go_router.dart';
import 'package:first_flutter_project/services/app_state_service.dart';
import 'package:first_flutter_project/locator.dart';

class CurrentAppointmentsWrapper extends StatefulWidget {
  @override
  _CurrentAppointmentsWrapperState createState() => _CurrentAppointmentsWrapperState();
}

class _CurrentAppointmentsWrapperState extends State<CurrentAppointmentsWrapper> {
  final AppStateService _appStateService = getIt<AppStateService>();  // ДОБАВЛЕНО: получаем сервис

  @override
  void initState() {
    super.initState();
    // Подписываемся на изменения
    _appStateService.addListener(_onStateChanged);
  }

  @override
  void dispose() {
    _appStateService.removeListener(_onStateChanged);
    super.dispose();
  }

  void _onStateChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Текущие записи'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              context.push('/profile');
            },
          ),
        ],
      ),
      body: CurrentAppointmentsScreen(
        appointments: _appStateService.currentAppointments,
        onCancelAppointment: _appStateService.cancelAppointment,
        onCompleteAppointment: _appStateService.completeAppointment,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/make');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}