import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:first_flutter_project/services/api_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<RegisterSubmitted>(_onRegisterSubmitted);
    on<LoginLogoutRequested>(_onLogoutRequested);
  }

  void _onLogoutRequested(LoginLogoutRequested event, Emitter<LoginState> emit) {
    emit(LoginInitial());
  }

  Future<void> _onLoginSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    if (event.username.isEmpty || event.password.isEmpty) {
      emit(const LoginFailure(error: 'Заполните все поля'));
      return;
    }

    emit(LoginLoading());
    try {
      final response = await ApiService.login(event.username, event.password);
      final role = response['role'] as String;
      final user = response['user'] as Map<String, dynamic>;
      emit(LoginSuccess(role: role, userData: user));
    } catch (e) {
      emit(LoginFailure(error: e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> _onRegisterSubmitted(RegisterSubmitted event, Emitter<LoginState> emit) async {
    if (event.username.isEmpty || event.password.isEmpty) {
      emit(const LoginFailure(error: 'Заполните все поля'));
      return;
    }

    emit(LoginLoading());
    try {
      await ApiService.register(
        event.username,
        event.password,
        event.firstName,
        event.lastName,
      );
      emit(RegisterSuccess());
    } catch (e) {
      emit(LoginFailure(error: e.toString().replaceAll('Exception: ', '')));
    }
  }
}
