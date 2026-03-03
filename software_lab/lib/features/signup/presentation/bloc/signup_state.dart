import 'package:software_lab/core/network/failures.dart';
import 'package:software_lab/features/signup/domain/entities/signup_entity.dart';

sealed class SignupState {
  const SignupState();
}

class SignupInitial extends SignupState {
  const SignupInitial();
}

class SignupLoading extends SignupState {
  const SignupLoading();
}

class SignupSuccess extends SignupState {
  final SignupEntity entity;

  const SignupSuccess(this.entity);
}

class SignupFailure extends SignupState {
  final Failure failure;

  const SignupFailure(this.failure);
}