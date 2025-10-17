import 'package:flutter/material.dart';
import '../models/appointment.dart';

class CurrentAppointmentsScreen extends StatelessWidget {
  final List<Appointment> appointments = [
    Appointment(
      doctorName: 'Др. Иванов',
      specialty: 'Кардиолог',
      date: '15.12.2023',
      time: '10:00',
    ),
    Appointment(
      doctorName: 'Др. Петрова',
      specialty: 'Невролог',
      date: '20.12.2023',
      time: '14:30',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Текущие записи')),
      body: ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (context, index) => AppointmentCard(appointments[index]),
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;

  AppointmentCard(this.appointment);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: ListTile(
        leading: Icon(Icons.medical_services),
        title: Text(appointment.doctorName),
        subtitle: Text('${appointment.specialty} • ${appointment.date} ${appointment.time}'),
        trailing: IconButton(
          icon: Icon(Icons.cancel),
          onPressed: () => _cancelAppointment(context),
        ),
      ),
    );
  }

  void _cancelAppointment(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Отменить запись?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Нет'),
          ),
          TextButton(
            onPressed: () {
              // Логика отмены записи
              Navigator.pop(context);
            },
            child: Text('Да'),
          ),
        ],
      ),
    );
  }
}