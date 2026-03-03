import 'package:fpdart/fpdart.dart';
import 'package:software_lab/core/network/failures.dart';
import 'package:software_lab/features/reset_password/data/datasources/password_reset_remote_datasource.dart';
import 'package:software_lab/features/reset_password/data/models/password_reset_request_models.dart';
import 'package:software_lab/features/reset_password/data/repositories/password_reset_repository.dart';
import 'package:software_lab/features/reset_password/domain/entities/password_reset_entity.dart';

class PasswordResetRepositoryImpl implements PasswordResetRepository {
  final PasswordResetRemoteDataSource _dataSource;

  const PasswordResetRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, PasswordResetEntity>> forgotPassword(
    ForgotPasswordRequestModel request,
  ) async {
    final result = await _dataSource.forgotPassword(request);

    return result.fold(
      (failure) => Left(failure),
      (response) {
        if (response.isSuccess) {
          return Right(response.toEntity());
        } else {
          return Left(ServerFailure(message: response.message));
        }
      },
    );
  }

  @override
  Future<Either<Failure, PasswordResetEntity>> verifyOtp(
    VerifyOtpRequestModel request,
  ) async {
    final result = await _dataSource.verifyOtp(request);

    return result.fold(
      (failure) => Left(failure),
      (response) {
        if (response.isSuccess) {
          return Right(response.toEntity());
        } else {
          return Left(ServerFailure(message: response.message));
        }
      },
    );
  }

  @override
  Future<Either<Failure, PasswordResetEntity>> resetPassword(
    ResetPasswordRequestModel request,
  ) async {
    final result = await _dataSource.resetPassword(request);

    return result.fold(
      (failure) => Left(failure),
      (response) {
        if (response.isSuccess) {
          return Right(response.toEntity());
        } else {
          return Left(ServerFailure(message: response.message));
        }
      },
    );
  }
}