part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoadSuccess extends ProfileState {
  final String name;
  final String specialty;
  final String experience;

  const ProfileLoadSuccess({
    required this.name,
    required this.specialty,
    required this.experience,
  });

  @override
  List<Object> get props => [name, specialty, experience];
}

class ProfileLogoutSuccess extends ProfileState {}