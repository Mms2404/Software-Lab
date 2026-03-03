import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:software_lab/features/signup/domain/repositories/signup_repository.dart';
import 'package:software_lab/features/signup/presentation/bloc/signup_event.dart';
import 'package:software_lab/features/signup/presentation/bloc/signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final SignupRepository _repository;

  SignupBloc(this._repository) : super(const SignupInitial()) {
    on<SignupSubmitted>(_onSignupSubmitted);
  }

  Future<void> _onSignupSubmitted(
    SignupSubmitted event,
    Emitter<SignupState> emit,
  ) async {
    emit(const SignupLoading());

    final result = await _repository.register(event.request);

    result.fold(
      (failure) => emit(SignupFailure(failure)),
      (entity) => emit(SignupSuccess(entity)),
    );
  }
}