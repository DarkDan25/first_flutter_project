import 'package:flutter/material.dart';
import 'package:first_flutter_project/models/appointment.dart';
import 'package:first_flutter_project/widgets/appointment_card.dart';
import 'package:first_flutter_project/app_state.dart';


class CurrentAppointmentsScreen extends StatefulWidget {
  final List<Appointment> appointments;
  final Function(String) onCancelAppointment;
  final Function(String) onCompleteAppointment;

  const CurrentAppointmentsScreen({
    super.key,
    required this.appointments,
    required this.onCancelAppointment,
    required this.onCompleteAppointment,
  });

  @override
  _CurrentAppointmentsScreenState createState() => _CurrentAppointmentsScreenState();
}
class _CurrentAppointmentsScreenState extends State<CurrentAppointmentsScreen> {

  @override
  Widget build(BuildContext context) {
    return  widget.appointments.isEmpty
          ? Center(
        child: Text(
          'Нет текущих записей',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
      : ListView.builder(
        itemCount:widget.appointments.length,
        itemBuilder: (context, index) => AppointmentCard(
          appointment: widget.appointments[index],
          onCancel: () => widget.onCancelAppointment(widget.appointments[index].id),
          onComplete: () => widget.onCompleteAppointment(widget.appointments[index].id),
        ),
    );
  }
}


