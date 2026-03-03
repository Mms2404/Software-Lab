

import 'package:software_lab/core/network/failures.dart';
import 'package:software_lab/features/reset_password/domain/entities/password_reset_entity.dart';

sealed class PasswordResetState {
  const PasswordResetState();
}

class PasswordResetInitial extends PasswordResetState {
  const PasswordResetInitial();
}

class PasswordResetLoading extends PasswordResetState {
  const PasswordResetLoading();
}

class OtpSentSuccess extends PasswordResetState {
  final PasswordResetEntity entity;

  const OtpSentSuccess(this.entity);
}

class OtpVerified extends PasswordResetState {
  final PasswordResetEntity entity;

  const OtpVerified(this.entity);
}

/// Password reset complete
class PasswordResetSuccess extends PasswordResetState {
  final PasswordResetEntity entity;

  const PasswordResetSuccess(this.entity);
}

class PasswordResetFailure extends PasswordResetState {
  final Failure failure;

  const PasswordResetFailure(this.failure);
}