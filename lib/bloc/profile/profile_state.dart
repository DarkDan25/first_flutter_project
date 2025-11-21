part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoadSuccess extends ProfileState {
  final String name;
  final String age;
  final String medCardId;

  const ProfileLoadSuccess({
    required this.name,
    required this.age,
    required this.medCardId,
  });

  @override
  List<Object> get props => [name, age, medCardId];
}

class ProfileLogoutSuccess extends ProfileState {}