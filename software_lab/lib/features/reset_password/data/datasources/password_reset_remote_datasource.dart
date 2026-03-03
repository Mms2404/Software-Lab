import 'package:fpdart/fpdart.dart';
import 'package:software_lab/core/network/api_client.dart';
import 'package:software_lab/core/network/api_constants.dart';
import 'package:software_lab/core/network/failures.dart';
import 'package:software_lab/features/reset_password/data/models/password_reset_request_models.dart';
import 'package:software_lab/features/reset_password/data/models/password_reset_response.dart';

class PasswordResetRemoteDataSource {
  final ApiClient _apiClient;

  const PasswordResetRemoteDataSource(this._apiClient);

  Future<Either<Failure, PasswordResetResponseModel>> forgotPassword(
    ForgotPasswordRequestModel request,
  ) async {
    final result = await _apiClient.post(
      ApiConstants.forgotPassword,
      data: request.toJson(),
    );

    return result.fold(
      (failure) => Left(failure),
      (response) {
        try {
          final model = PasswordResetResponseModel.fromJson(response.data);
          return Right(model);
        } catch (e) {
          return Left(UnknownFailure(message: 'Failed to parse response: $e'));
        }
      },
    );
  }

  Future<Either<Failure, PasswordResetResponseModel>> verifyOtp(
    VerifyOtpRequestModel request,
  ) async {
    final result = await _apiClient.post(
      ApiConstants.verifyOtp,
      data: request.toJson(),
    );

    return result.fold(
      (failure) => Left(failure),
      (response) {
        try {
          final model = PasswordResetResponseModel.fromJson(response.data);
          return Right(model);
        } catch (e) {
          return Left(UnknownFailure(message: 'Failed to parse response: $e'));
        }
      },
    );
  }

  Future<Either<Failure, PasswordResetResponseModel>> resetPassword(
    ResetPasswordRequestModel request,
  ) async {
    final result = await _apiClient.post(
      ApiConstants.resetPassword,
      data: request.toJson(),
    );

    return result.fold(
      (failure) => Left(failure),
      (response) {
        try {
          final model = PasswordResetResponseModel.fromJson(response.data);
          return Right(model);
        } catch (e) {
          return Left(UnknownFailure(message: 'Failed to parse response: $e'));
        }
      },
    );
  }
}