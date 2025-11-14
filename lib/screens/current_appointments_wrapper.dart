import 'package:flutter/material.dart';
import 'package:first_flutter_project/screens/current_appointments_screen.dart';
import 'package:first_flutter_project/screens/make_appointment_screen.dart';
import 'package:first_flutter_project/screens/profile_screen.dart';
import 'package:first_flutter_project/models/appointment.dart';
import 'package:go_router/go_router.dart';

class CurrentAppointmentsWrapper extends StatefulWidget {
  @override
  _CurrentAppointmentsWrapperState createState() => _CurrentAppointmentsWrapperState();
}

class _CurrentAppointmentsWrapperState extends State<CurrentAppointmentsWrapper> {
  List<Appointment> _currentAppointments = [];

  List<Appointment> _historyAppointments = [];

  void _addAppointment(Appointment newAppointment) {
    setState(() {
      _currentAppointments.add(newAppointment);
    });
  }

  void _cancelAppointment(String appointmentId) {
    setState(() {
      _currentAppointments.removeWhere((appointment) => appointment.id == appointmentId);
    });
  }

  void _completeAppointment(String appointmentId) {
    setState(() {
      final appointment = _currentAppointments.firstWhere(
            (appt) => appt.id == appointmentId,
      );
      _currentAppointments.removeWhere((appt) => appt.id == appointmentId);
      _historyAppointments.add(appointment);

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Текущие записи'),
          automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              context.push('/profile', extra: _historyAppointments);
            },
          ),
        ],
      ),
      body: CurrentAppointmentsScreen(
        appointments: _currentAppointments,
        onCancelAppointment: _cancelAppointment,
        onCompleteAppointment: _completeAppointment,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/make', extra: _addAppointment);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}