import 'package:fpdart/fpdart.dart';
import 'package:software_lab/core/network/failures.dart';
import 'package:software_lab/features/reset_password/data/models/password_reset_request_models.dart';
import 'package:software_lab/features/reset_password/domain/entities/password_reset_entity.dart';

abstract class PasswordResetRepository {
  Future<Either<Failure, PasswordResetEntity>> forgotPassword(
    ForgotPasswordRequestModel request,
  );

  Future<Either<Failure, PasswordResetEntity>> verifyOtp(
    VerifyOtpRequestModel request,
  );

  Future<Either<Failure, PasswordResetEntity>> resetPassword(
    ResetPasswordRequestModel request,
  );
}