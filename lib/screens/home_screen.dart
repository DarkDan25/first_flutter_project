import 'package:flutter/material.dart';
import 'current_appointments_screen.dart';
import 'make_appointment_screen.dart';
import 'appointment_history_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    CurrentAppointmentsScreen(),
    MakeAppointmentScreen(),
    AppointmentHistoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
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