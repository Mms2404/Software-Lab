import 'package:fpdart/fpdart.dart';
import 'package:software_lab/core/network/failures.dart';
import 'package:software_lab/features/signup/data/datasources/signup_remote_datasource.dart';
import 'package:software_lab/features/signup/data/models/signup_request_model.dart';
import 'package:software_lab/features/signup/domain/entities/signup_entity.dart';
import 'package:software_lab/features/signup/domain/repositories/signup_repository.dart';

class SignupRepositoryImpl implements SignupRepository {
  final SignupRemoteDataSource _dataSource;

  const SignupRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, SignupEntity>> register(
    SignupRequestModel request,
  ) async {
    final result = await _dataSource.register(request);

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