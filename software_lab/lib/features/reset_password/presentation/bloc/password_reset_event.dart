

import 'package:software_lab/features/reset_password/data/models/password_reset_request_models.dart';

sealed class PasswordResetEvent {
  const PasswordResetEvent();
}

class ForgotPasswordSubmitted extends PasswordResetEvent {
  final ForgotPasswordRequestModel request;

  const ForgotPasswordSubmitted(this.request);
}

class OtpVerificationSubmitted extends PasswordResetEvent {
  final VerifyOtpRequestModel request;

  const OtpVerificationSubmitted(this.request);
}

class ResetPasswordSubmitted extends PasswordResetEvent {
  final ResetPasswordRequestModel request;

  const ResetPasswordSubmitted(this.request);
}