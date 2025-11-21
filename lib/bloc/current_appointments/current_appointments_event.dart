part of 'current_appointments_bloc.dart';

abstract class CurrentAppointmentsEvent extends Equatable {
  const CurrentAppointmentsEvent();

  @override
  List<Object> get props => [];
}

class LoadCurrentAppointments extends CurrentAppointmentsEvent {}

class CancelAppointment extends CurrentAppointmentsEvent {
  final String appointmentId;

  const CancelAppointment(this.appointmentId);

  @override
  List<Object> get props => [appointmentId];
}

class CompleteAppointment extends CurrentAppointmentsEvent {
  final String appointmentId;

  const CompleteAppointment(this.appointmentId);

  @override
  List<Object> get props => [appointmentId];
}