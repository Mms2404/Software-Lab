import 'package:fpdart/fpdart.dart';
import 'package:software_lab/features/signup/domain/entities/signup_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/signup_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<String, String>> signup(SignUpEntity entity) async {
    try {
      final model = SignupModel.fromEntity(entity);
      final token = await remoteDataSource.signup(model);
      return Right(token);
    } catch (e) {
      return Left(e.toString());
    }
  }
}