part of 'patients_management_bloc.dart';

abstract class PatientsManagementState extends Equatable {
  const PatientsManagementState();
  
  @override
  List<Object> get props => [];
}

class PatientsManagementInitial extends PatientsManagementState {}

class PatientsLoading extends PatientsManagementState {}

class PatientsLoaded extends PatientsManagementState {
  final List<Patient> patients;
  const PatientsLoaded({required this.patients});

  @override
  List<Object> get props => [patients];
}

class PatientsError extends PatientsManagementState {
  final String message;
  const PatientsError({required this.message});

  @override
  List<Object> get props => [message];
}
