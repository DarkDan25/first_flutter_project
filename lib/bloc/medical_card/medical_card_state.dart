part of 'medical_card_bloc.dart';

abstract class MedicalCardState extends Equatable {
  const MedicalCardState();

  @override
  List<Object> get props => [];
}

class MedicalCardInitial extends MedicalCardState {}

class MedicalCardLoaded extends MedicalCardState {
  final String medCardId;
  final String patientName;
  final String age;
  final String bloodType;
  final String allergies;
  final String chronicDiseases;
  final String notes;
  final List<String> medications;
  final Appointment? lastAppointment;
  final Appointment? nextAppointment;

  const MedicalCardLoaded({
    required this.medCardId,
    required this.patientName,
    required this.age,
    required this.bloodType,
    required this.allergies,
    required this.chronicDiseases,
    required this.notes,
    required this.medications,
    this.lastAppointment,
    this.nextAppointment,
  });

  @override
  List<Object> get props => [
    medCardId,
    patientName,
    age,
    bloodType,
    allergies,
    chronicDiseases,
    notes,
    medications,
    if (lastAppointment != null) lastAppointment!,
    if (nextAppointment != null) nextAppointment!,
  ];
}