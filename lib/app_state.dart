import 'package:flutter/material.dart';
import 'package:first_flutter_project/models/appointment.dart';

class AppState extends InheritedWidget {
  final List<Appointment> currentAppointments;
  final List<Appointment> historyAppointments;
  final Function(Appointment) addAppointment;
  final Function(String) cancelAppointment;
  final Function(String) completeAppointment;
  final VoidCallback refresh;

  const AppState({
    Key? key,
    required Widget child,
    required this.currentAppointments,
    required this.historyAppointments,
    required this.addAppointment,
    required this.cancelAppointment,
    required this.completeAppointment,
    required this.refresh,
  }) : super(key: key, child: child);

  static AppState of(BuildContext context) {
    final AppState? result = context.dependOnInheritedWidgetOfExactType<AppState>();
    assert(result != null, 'No AppState found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(AppState old) {
    return currentAppointments != old.currentAppointments ||
        historyAppointments != old.historyAppointments;
  }
}

class AppStateWrapper extends StatefulWidget {
  final Widget child;

  const AppStateWrapper({Key? key, required this.child}) : super(key: key);

  @override
  _AppStateWrapperState createState() => _AppStateWrapperState();
}

class _AppStateWrapperState extends State<AppStateWrapper> {
  List<Appointment> _currentAppointments = [];

  List<Appointment> _historyAppointments = [];

  void _refresh(){
    setState(() {

    });
  }

  void _addAppointment(Appointment newAppointment) {
    setState(() {
      _currentAppointments = [..._currentAppointments, newAppointment];
    });
  }

  void _cancelAppointment(String appointmentId) {
    setState(() {
      _currentAppointments = _currentAppointments.where((appointment) => appointment.id != appointmentId).toList();
    });
  }

  void _completeAppointment(String appointmentId) {
    setState(() {
      final appointment = _currentAppointments.firstWhere((appt) => appt.id == appointmentId);
      _currentAppointments = _currentAppointments.where((appt) => appt.id != appointmentId).toList();
      _historyAppointments = [..._historyAppointments, appointment];
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppState(
      currentAppointments: _currentAppointments,
      historyAppointments: _historyAppointments,
      addAppointment: _addAppointment,
      cancelAppointment: _cancelAppointment,
      completeAppointment: _completeAppointment,
      refresh: _refresh,
      child: widget.child,
    );
  }
}