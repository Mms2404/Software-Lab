import 'package:fpdart/fpdart.dart';
import 'package:software_lab/core/network/failures.dart';
import 'package:software_lab/features/signup/data/models/signup_request_model.dart';
import 'package:software_lab/features/signup/domain/entities/signup_entity.dart';

abstract class SignupRepository {
  Future<Either<Failure, SignupEntity>> register(SignupRequestModel request);
}