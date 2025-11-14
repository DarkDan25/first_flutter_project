import 'package:flutter/material.dart';
import 'package:first_flutter_project/screens/current_appointments_screen.dart';
import 'package:first_flutter_project/screens/make_appointment_screen.dart';
import 'package:first_flutter_project/screens/profile_screen.dart';
import 'package:first_flutter_project/models/appointment.dart';
import 'package:go_router/go_router.dart';
import 'package:first_flutter_project/app_state.dart';

class CurrentAppointmentsWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = AppState.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Текущие записи'),
          automaticallyImplyLeading: false,
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
        appointments: appState.currentAppointments,
        onCancelAppointment: appState.cancelAppointment,
        onCompleteAppointment: appState.completeAppointment,
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