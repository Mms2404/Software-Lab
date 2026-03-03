import 'package:fpdart/fpdart.dart';
import 'package:software_lab/core/network/failures.dart';
import 'package:software_lab/features/login/data/datasources/login_remote_datasource.dart';
import 'package:software_lab/features/login/data/models/login_model.dart';
import 'package:software_lab/features/login/data/repositories/login_repository.dart';
import 'package:software_lab/features/login/domain/entities/login_entity.dart';

class LoginRepositoryImpl implements LoginRepository{
  final LoginRemoteDataSource _dataSource;

  const LoginRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, LoginEntity>> login(LoginRequestModel request) async {
    final result = await _dataSource.login(request);

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