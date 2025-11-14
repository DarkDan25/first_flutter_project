import 'package:flutter/material.dart';
import 'current_appointments_screen.dart';
import 'make_appointment_screen.dart';
import 'profile_screen.dart';
import '../models/appointment.dart';
import '../data/doctors_data.dart';

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
          // Кнопка для перехода к профилю
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen(
                  historyAppointments: _historyAppointments,
                )),
              );
            },
          ),
        ],
      ),
      body: CurrentAppointmentsScreen(
        appointments: _currentAppointments,
        onCancelAppointment: _cancelAppointment,
        onCompleteAppointment: _completeAppointment,
      ),
      // Кнопка для перехода к созданию записи
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MakeAppointmentScreen(
                onAddAppointment: _addAppointment,
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}