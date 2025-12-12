part of 'medical_card_bloc.dart';

abstract class MedicalCardEvent extends Equatable {
  const MedicalCardEvent();

  @override
  List<Object> get props => [];
}

class LoadMedicalCard extends MedicalCardEvent {}

class UpdateAppointmentsInfo extends MedicalCardEvent {
  final Appointment? lastAppointment;
  final Appointment? nextAppointment;

  const UpdateAppointmentsInfo({
    this.lastAppointment,
    this.nextAppointment,
  });

  @override
  List<Object> get props => [
    if (lastAppointment != null) lastAppointment!,
    if (nextAppointment != null) nextAppointment!,
  ];
}