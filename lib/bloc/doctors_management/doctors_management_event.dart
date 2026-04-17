part of 'doctors_management_bloc.dart';

abstract class DoctorsManagementEvent extends Equatable {
  const DoctorsManagementEvent();

  @override
  List<Object> get props => [];
}

class LoadDoctors extends DoctorsManagementEvent {}

class AddDoctor extends DoctorsManagementEvent {
  final Doctor doctor;

  const AddDoctor(this.doctor);

  @override
  List<Object> get props => [doctor];
}

class UpdateDoctor extends DoctorsManagementEvent {
  final Doctor doctor;

  const UpdateDoctor(this.doctor);

  @override
  List<Object> get props => [doctor];
}

class DeleteDoctor extends DoctorsManagementEvent {
  final int doctorId;

  const DeleteDoctor(this.doctorId);

  @override
  List<Object> get props => [doctorId];
}