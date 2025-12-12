part of 'doctors_management_bloc.dart';

abstract class DoctorsManagementState extends Equatable {
  const DoctorsManagementState();

  @override
  List<Object> get props => [];
}

class DoctorsManagementInitial extends DoctorsManagementState {}

class DoctorsLoaded extends DoctorsManagementState {
  final List<Doctor> doctors;

  const DoctorsLoaded(this.doctors);

  @override
  List<Object> get props => [doctors];
}