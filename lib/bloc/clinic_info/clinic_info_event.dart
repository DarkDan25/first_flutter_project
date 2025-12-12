part of 'clinic_info_bloc.dart';

abstract class ClinicInfoEvent extends Equatable {
  const ClinicInfoEvent();

  @override
  List<Object> get props => [];
}

class LoadClinicInfo extends ClinicInfoEvent {}