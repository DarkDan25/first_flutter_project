import 'package:flutter/material.dart';
import 'package:first_flutter_project/screens/current_appointments_screen.dart';
import 'package:first_flutter_project/screens/make_appointment_screen.dart';
import 'package:first_flutter_project/screens/appointment_history_screen.dart';
import 'package:first_flutter_project/models/appointment.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

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
    final List<Widget> _screens = [
      CurrentAppointmentsScreen(
        appointments: _currentAppointments,
        onCancelAppointment: _cancelAppointment,
        onCompleteAppointment: _completeAppointment,
      ),
      MakeAppointmentScreen(),
      AppointmentHistoryScreen(historyAppointments: _historyAppointments),
    ];

    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.today),
            label: 'Текущие записи',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: 'Запись к врачу',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'История записей',
          ),
        ],
      ),
    );
  }
}