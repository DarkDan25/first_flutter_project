import 'package:flutter/material.dart';
import 'package:first_flutter_project/models/appointment.dart';
import 'package:first_flutter_project/widgets/history_card.dart';

class AppointmentHistoryScreen extends StatelessWidget {
  final List<Appointment> historyAppointments;

  const AppointmentHistoryScreen({Key? key, required this.historyAppointments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('История записей')),
      body: historyAppointments.isEmpty
          ? Center(
        child: Text(
          'История записей пуста',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : ListView.builder(
        itemCount: historyAppointments.length,
        itemBuilder: (context, index) => HistoryCard(historyAppointments[index]),
      ),
    );
  }
}

