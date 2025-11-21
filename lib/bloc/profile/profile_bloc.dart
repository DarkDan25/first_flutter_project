import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileLoadRequested>(_onProfileLoadRequested);
    on<ProfileLogoutRequested>(_onProfileLogoutRequested);
  }

  void _onProfileLoadRequested(ProfileLoadRequested event, Emitter<ProfileState> emit) {
    emit(ProfileLoadSuccess(
      name: 'Иванов Ф.П.',
      age: '25 лет',
      medCardId: '1234567890',
    ));
  }

  void _onProfileLogoutRequested(ProfileLogoutRequested event, Emitter<ProfileState> emit) {
    emit(ProfileLogoutSuccess());
  }
}