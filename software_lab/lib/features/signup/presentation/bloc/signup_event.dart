import 'package:equatable/equatable.dart';
import 'package:software_lab/features/signup/domain/entities/signup_entity.dart';

abstract class SignupEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignupSubmitted extends SignupEvent {
  final SignUpEntity entity;

  SignupSubmitted(this.entity);

  @override
  List<Object?> get props => [entity];
}