part of 'make_appointment_bloc.dart';

abstract class MakeAppointmentState extends Equatable {
  const MakeAppointmentState();

  @override
  List<Object> get props => [];
}

class MakeAppointmentInitial extends MakeAppointmentState {}

class AppointmentSubmitted extends MakeAppointmentState {
  final Appointment appointment;

  const AppointmentSubmitted(this.appointment);

  @override
  List<Object> get props => [appointment];
}