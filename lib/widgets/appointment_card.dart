import 'package:flutter/material.dart';
import 'package:first_flutter_project/models/appointment.dart';
import 'package:first_flutter_project/widgets/cached_doctor_image.dart';
import 'package:first_flutter_project/app_state.dart';


class AppointmentCard extends StatelessWidget {
  final Appointment appointment;
  final VoidCallback onCancel;
  final VoidCallback onComplete;

  const AppointmentCard({
    super.key,
    required this.appointment,
    required this.onCancel,
    required this.onComplete,
  });

  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            // Добавляем изображение врача

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedDoctorImage(
                    imageUrl: appointment.imageUrl,
                    //localAsset: appointment.localAsset,
                    // width: 50,
                    // height: 50,
                  ),
                  SizedBox(width: 12),
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
                ],
              ),
            ),
            Column(
              children: [
                TextButton(
                  onPressed: () => _cancelAppointment(context),
                  child: Text('Отменить'),
                ),
                SizedBox(height: 4),
                ElevatedButton(
                  onPressed: () => _completeAppointment(context),
                  child: Text('Завершить'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _cancelAppointment(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Отменить запись?'),
        content: Text('Вы уверены, что хотите отменить запись к ${appointment.doctorName}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Нет'),
          ),
          TextButton(
            onPressed: () {
              onCancel();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Запись отменена')),
              );
              AppState.of(context).refresh();
            },
            child: Text('Да'),
          ),
        ],
      ),
    );
  }

  void _completeAppointment(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Завершить запись?'),
        content: Text('Подтвердите, что прием у ${appointment.doctorName} завершен.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              onComplete();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Запись перемещена в историю')),
              );
              AppState.of(context).refresh();
            },
            child: Text('Подтвердить'),
          ),
        ],
      ),
    );
  }
}