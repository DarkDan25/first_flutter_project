import 'package:flutter/material.dart';
import 'package:first_flutter_project/models/appointment.dart';

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;
  final VoidCallback onCancel;
  final VoidCallback onComplete;

  const AppointmentCard({
    Key? key,
    required this.appointment,
    required this.onCancel,
    required this.onComplete,
  }) : super(key: key);

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
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => _cancelAppointment(context),
                  child: Text('Отменить'),
                ),
                SizedBox(width: 8),
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
            },
            child: Text('Подтвердить'),
          ),
        ],
      ),
    );
  }
}