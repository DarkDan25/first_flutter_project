import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'appointment_history_screen.dart';
import 'package:first_flutter_project/models/appointment.dart';
import 'package:first_flutter_project/app_state.dart';


class AppointmentHistoryWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = AppState.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('История записей (${appState.historyAppointments.length})'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: AppointmentHistoryScreen(historyAppointments: appState.historyAppointments),
    );
  }
}