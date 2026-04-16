import 'package:flutter/material.dart';
import 'package:first_flutter_project/models/appointment.dart';


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
                ],
              ),
            ),
            Column(
              children: [
                TextButton(
                  onPressed: () => _cancelAppointment(context),
                  child: const Text('Отменить'),
                ),
                const SizedBox(height: 4),
                ElevatedButton(
                  onPressed: () => _completeAppointment(context),
                  child: const Text('Завершить'),
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
        title: const Text('Отменить запись?'),
        content: Text('Вы уверены, что хотите отменить запись к ${appointment.doctor.fullName}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Нет'),
          ),
          TextButton(
            onPressed: () {
              onCancel();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Запись отменена')),
              );
            },
            child: const Text('Да'),
          ),
        ],
      ),
    );
  }

  void _completeAppointment(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Завершить запись?'),
        content: Text('Подтвердите, что прием у ${appointment.doctor.fullName} завершен.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              onComplete();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Запись перемещена в историю')),
              );
            },
            child: const Text('Подтвердить'),
          ),
        ],
      ),
    );
  }
}
