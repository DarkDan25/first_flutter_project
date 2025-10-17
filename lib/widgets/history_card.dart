import 'package:flutter/material.dart';
import 'package:first_flutter_project/models/appointment.dart';

class HistoryCard extends StatelessWidget {
  final Appointment appointment;

  const HistoryCard(this.appointment, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appointment.doctorName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),
            Text(appointment.specialty),
            SizedBox(height: 8),
            Text('${appointment.date} ${appointment.time}'),
            SizedBox(height: 8),
            Text(
              'Завершено',
              style: TextStyle(
                color: Colors.green,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}