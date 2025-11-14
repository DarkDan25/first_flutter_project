import 'package:flutter/material.dart';
import 'appointment_history_screen.dart';
import 'package:first_flutter_project/models/appointment.dart';

class AppointmentHistoryWrapper extends StatefulWidget {
  final List<Appointment> historyAppointments;

  const AppointmentHistoryWrapper({Key? key, required this.historyAppointments}) : super(key: key);

  @override
  _AppointmentHistoryWrapperState createState() => _AppointmentHistoryWrapperState();
}

class _AppointmentHistoryWrapperState extends State<AppointmentHistoryWrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('История записей (${widget.historyAppointments.length})'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: AppointmentHistoryScreen(historyAppointments: widget.historyAppointments),
    );
  }
}