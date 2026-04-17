part of 'make_appointment_bloc.dart';

abstract class MakeAppointmentState extends Equatable {
  const MakeAppointmentState();

  @override
  List<Object> get props => [];
}

class MakeAppointmentInitial extends MakeAppointmentState {}

class MakeAppointmentLoading extends MakeAppointmentState {}

class AppointmentSubmitted extends MakeAppointmentState {
  final Appointment appointment;

  const AppointmentSubmitted(this.appointment);

  @override
  List<Object> get props => [appointment];
}

class MakeAppointmentFailure extends MakeAppointmentState {
  final String error;

  const MakeAppointmentFailure(this.error);

  @override
  List<Object> get props => [error];
}