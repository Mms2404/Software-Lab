import 'package:fpdart/fpdart.dart';
import 'package:software_lab/core/network/failures.dart';
import 'package:software_lab/features/login/data/models/login_model.dart';
import 'package:software_lab/features/login/domain/entities/login_entity.dart';

abstract class LoginRepository {
  Future<Either<Failure, LoginEntity>> login(LoginRequestModel request);
}