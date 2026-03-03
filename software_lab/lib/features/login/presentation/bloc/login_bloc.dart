import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:software_lab/features/login/data/repositories/login_repository.dart';
import 'package:software_lab/features/login/presentation/bloc/login_event.dart';
import 'package:software_lab/features/login/presentation/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository _repository;

  LoginBloc(this._repository) : super(const LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(const LoginLoading());

    final result = await _repository.login(event.request);

    result.fold(
      (failure) => emit(LoginFailure(failure)),
      (entity) => emit(LoginSuccess(entity)),
    );
  }
}