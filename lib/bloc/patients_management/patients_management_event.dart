part of 'patients_management_bloc.dart';

abstract class PatientsManagementEvent extends Equatable {
  const PatientsManagementEvent();

  @override
  List<Object> get props => [];
}

class LoadPatients extends PatientsManagementEvent {}

class UpdatePatient extends PatientsManagementEvent {
  final Patient patient;
  const UpdatePatient(this.patient);

  @override
  List<Object> get props => [patient];
}

class DeletePatient extends PatientsManagementEvent {
  final int id;
  const DeletePatient(this.id);

  @override
  List<Object> get props => [id];
}
