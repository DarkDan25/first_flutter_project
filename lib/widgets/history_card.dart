import 'package:flutter/material.dart';
import 'package:first_flutter_project/models/appointment.dart';

import 'package:first_flutter_project/widgets/cached_doctor_image.dart';

class HistoryCard extends StatelessWidget {
  final Appointment appointment;

  const HistoryCard(this.appointment, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            // Добавляем изображение врача
            CachedDoctorImage(
              imageUrl: appointment.imageUrl,
              //localAsset: appointment.localAsset,
              // width: 50,
              // height: 50,
            ),
            SizedBox(width: 12),
            Expanded(
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
                  SizedBox(height: 4),
                  Text(appointment.specialty),
                  SizedBox(height: 4),
                  Text('${appointment.date} ${appointment.time}'),
                  SizedBox(height: 4),
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
          ],
        ),
      ),
    );
  }
}