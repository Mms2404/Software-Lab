import 'package:fpdart/fpdart.dart';
import 'package:software_lab/features/signup/domain/entities/signup_entity.dart';


abstract class AuthRepository {
  Future<Either<String, String>> signup(SignUpEntity entity);
}