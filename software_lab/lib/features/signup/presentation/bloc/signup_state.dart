import 'package:equatable/equatable.dart';

abstract class SignupState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupSuccess extends SignupState {
  final String token;

  SignupSuccess(this.token);

  @override
  List<Object?> get props => [token];
}

class SignupFailure extends SignupState {
  final String message;

  SignupFailure(this.message);

  @override
  List<Object?> get props => [message];
}