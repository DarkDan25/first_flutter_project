import 'package:flutter/material.dart';
import '../models/appointment.dart';

class AppStateService extends ChangeNotifier {
  List<Appointment> _currentAppointments = [];

  List<Appointment> _historyAppointments = [];

  List<Appointment> get currentAppointments => _currentAppointments;
  List<Appointment> get historyAppointments => _historyAppointments;

  void addAppointment(Appointment newAppointment) {
    _currentAppointments = [..._currentAppointments, newAppointment];
    notifyListeners();
  }

  void cancelAppointment(String appointmentId) {
    _currentAppointments = _currentAppointments.where((appointment) => appointment.id != appointmentId).toList();
    notifyListeners();
  }

  void completeAppointment(String appointmentId) {
    final appointment = _currentAppointments.firstWhere((appt) => appt.id == appointmentId);
    _currentAppointments = _currentAppointments.where((appt) => appt.id != appointmentId).toList();
    _historyAppointments = [..._historyAppointments, appointment];
    notifyListeners();
  }
}