import 'package:flutter/material.dart';
import 'package:first_flutter_project/models/appointment.dart';

class HistoryCard extends StatelessWidget {
  final Appointment appointment;

  const HistoryCard(this.appointment, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appointment.doctor.fullName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(appointment.doctor.specialty),
                  const SizedBox(height: 4),
                  Text(appointment.date),
                  const SizedBox(height: 4),
                  const Text(
                    'Завершено',
                    style: TextStyle(
                      color: Colors.green,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
