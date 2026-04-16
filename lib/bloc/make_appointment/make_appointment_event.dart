part of 'make_appointment_bloc.dart';

abstract class MakeAppointmentEvent extends Equatable {
  const MakeAppointmentEvent();

  @override
  List<Object> get props => [];
}

class SubmitAppointment extends MakeAppointmentEvent {
  final String doctorName;
  final String specialty;
  final String date;
  final String time;

  const SubmitAppointment({
    required this.doctorName,
    required this.specialty,
    required this.date,
    required this.time,
  });

  @override
  List<Object> get props => [doctorName, specialty, date, time];
}