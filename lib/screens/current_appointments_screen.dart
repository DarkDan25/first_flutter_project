import 'package:flutter/material.dart';
import 'package:first_flutter_project/models/appointment.dart';
import 'package:first_flutter_project/widgets/appointment_card.dart';


class CurrentAppointmentsScreen extends StatelessWidget {
  final List<Appointment> appointments;
  final Function(int) onCancelAppointment;
  final Function(int) onCompleteAppointment;
  final String role;

  const CurrentAppointmentsScreen({
    super.key,
    required this.appointments,
    required this.onCancelAppointment,
    required this.onCompleteAppointment,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return  appointments.isEmpty
          ? Center(
        child: Text(
          'Нет текущих записей',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
      : ListView.builder(
        itemCount:appointments.length,
        itemBuilder: (context, index) => AppointmentCard(
          appointment: appointments[index],
          role: role,
          onCancel: () => onCancelAppointment(appointments[index].id!),
          onComplete: () => onCompleteAppointment(appointments[index].id!),
        ),
    );
  }
}


