part of 'clinic_info_bloc.dart';

abstract class ClinicInfoState extends Equatable {
  const ClinicInfoState();

  @override
  List<Object> get props => [];
}

class ClinicInfoInitial extends ClinicInfoState {}

class ClinicInfoLoaded extends ClinicInfoState {
  final String name;
  final String address;
  final String phone;
  final String email;
  final String workingHours;
  final String description;

  const ClinicInfoLoaded({
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.workingHours,
    required this.description,
  });

  @override
  List<Object> get props => [name, address, phone, email, workingHours, description];
}