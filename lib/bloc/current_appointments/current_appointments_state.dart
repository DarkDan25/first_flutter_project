part of 'current_appointments_bloc.dart';

abstract class CurrentAppointmentsState extends Equatable {
  const CurrentAppointmentsState();

  @override
  List<Object> get props => [];
}

class CurrentAppointmentsInitial extends CurrentAppointmentsState {}

class CurrentAppointmentsLoaded extends CurrentAppointmentsState {
  final List<Appointment> appointments;

  const CurrentAppointmentsLoaded(this.appointments);

  @override
  List<Object> get props => [appointments];
}