part of 'make_appointment_bloc.dart';


abstract class MakeAppointmentEvent extends Equatable {
  const MakeAppointmentEvent();

  @override
  List<Object> get props => [];
}

class SubmitAppointment extends MakeAppointmentEvent {
  final Doctor doctor;
  final Patient patient;
  final String date;
  final String time;

  const SubmitAppointment({
    required this.doctor,
    required this.patient,
    required this.date,
    required this.time,
  });

  @override
  List<Object> get props => [doctor, patient, date, time];
}
