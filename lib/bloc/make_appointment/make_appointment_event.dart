part of 'make_appointment_bloc.dart';

abstract class MakeAppointmentEvent extends Equatable {
  const MakeAppointmentEvent();

  @override
  List<Object> get props => [];
}

class SubmitAppointment extends MakeAppointmentEvent {
  final Doctor doctor;
  final String date;

  const SubmitAppointment({
    required this.doctor,
    required this.date,
  });

  @override
  List<Object> get props => [doctor, date];
}
