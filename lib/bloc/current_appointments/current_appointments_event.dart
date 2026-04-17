part of 'current_appointments_bloc.dart';

abstract class CurrentAppointmentsEvent extends Equatable {
  const CurrentAppointmentsEvent();

  @override
  List<Object> get props => [];
}

class LoadCurrentAppointments extends CurrentAppointmentsEvent {
  final String role;
  final int userId;

  const LoadCurrentAppointments({required this.role, required this.userId});

  @override
  List<Object> get props => [role, userId];
}

class CancelAppointment extends CurrentAppointmentsEvent {
  final int appointmentId;

  const CancelAppointment(this.appointmentId);

  @override
  List<Object> get props => [appointmentId];
}

class CompleteAppointment extends CurrentAppointmentsEvent {
  final int appointmentId;

  const CompleteAppointment(this.appointmentId);

  @override
  List<Object> get props => [appointmentId];
}
class AddAppointment extends CurrentAppointmentsEvent {
  final Appointment appointment;

  const AddAppointment(this.appointment);

  @override
  List<Object> get props => [appointment];
}