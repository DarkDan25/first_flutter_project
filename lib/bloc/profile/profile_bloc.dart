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
      name: 'Доктор Иванов',
      specialty: 'Кардиолог',
      experience: '15 лет',
    ));
  }

  void _onProfileLogoutRequested(ProfileLogoutRequested event, Emitter<ProfileState> emit) {
    emit(ProfileLogoutSuccess());
  }
}