import 'package:software_lab/core/network/failures.dart';
import 'package:software_lab/features/login/domain/entities/login_entity.dart';

sealed class LoginState {
  const LoginState();
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginSuccess extends LoginState {
  final LoginEntity entity;

  const LoginSuccess(this.entity);
}

class LoginFailure extends LoginState {
  final Failure failure;

  const LoginFailure(this.failure);
}