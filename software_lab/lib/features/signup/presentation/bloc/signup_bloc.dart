import 'package:bloc/bloc.dart';
import 'package:software_lab/features/signup/domain/repositories/auth_repository.dart';

import 'signup_event.dart';
import 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final AuthRepository repository;

  SignupBloc(this.repository) : super(SignupInitial()) {
    on<SignupSubmitted>(_onSignupSubmitted);
  }

  Future<void> _onSignupSubmitted(
    SignupSubmitted event,
    Emitter<SignupState> emit,
  ) async {
    emit(SignupLoading());

    final result = await repository.signup(event.entity);

    result.fold(
      (failure) => emit(SignupFailure(failure)),
      (token) => emit(SignupSuccess(token)),
    );
  }
}