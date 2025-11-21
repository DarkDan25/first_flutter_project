import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  void _onLoginSubmitted(LoginSubmitted event, Emitter<LoginState> emit) {
    if (event.username.isEmpty || event.password.isEmpty) {
      emit(LoginFailure(error: 'Заполните все поля'));
    } else {
      emit(LoginSuccess());
    }
  }
}