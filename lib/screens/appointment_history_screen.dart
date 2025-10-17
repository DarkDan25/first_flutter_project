import 'package:flutter/material.dart';
import '../models/appointment.dart';

class AppointmentHistoryScreen extends StatelessWidget {
  final List<Appointment> historyAppointments = [
    Appointment(
      doctorName: 'Др. Сидоров',
      specialty: 'Терапевт',
      date: '01.12.2023',
      time: '11:00',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('История записей')),
      body: ListView.builder(
        itemCount: historyAppointments.length,
        itemBuilder: (context, index) => HistoryCard(historyAppointments[index]),
      ),
    );
  }
}

class HistoryCard extends StatelessWidget {
  final Appointment appointment;

  HistoryCard(this.appointment);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: ListTile(
        leading: Icon(Icons.medical_services),
        title: Text(appointment.doctorName),
        subtitle: Text('${appointment.specialty} • ${appointment.date} ${appointment.time}'),
        trailing: Icon(Icons.check_circle, color: Colors.green),
      ),
    );
  }
}