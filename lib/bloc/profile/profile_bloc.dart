import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileLogoutRequested>(_onProfileLogoutRequested);
  }

  void _onProfileLogoutRequested(ProfileLogoutRequested event, Emitter<ProfileState> emit) {
    emit(ProfileLogoutSuccess());
  }
}