import 'package:fpdart/fpdart.dart';
import 'package:software_lab/core/network/api_client.dart';
import 'package:software_lab/core/network/api_constants.dart';
import 'package:software_lab/core/network/failures.dart';
import 'package:software_lab/features/signup/data/models/signup_request_model.dart';
import 'package:software_lab/features/signup/data/models/signup_response_model.dart';

class SignupRemoteDataSource {
  final ApiClient _apiClient;

  const SignupRemoteDataSource(this._apiClient);

  Future<Either<Failure, SignupResponseModel>> register(
    SignupRequestModel request,
  ) async {
    final result = await _apiClient.post(
      ApiConstants.register,
      data: request.toJson(),
    );

    return result.fold(
      (failure) => Left(failure),
      (response) {
        try {
          final model = SignupResponseModel.fromJson(response.data);
          return Right(model);
        } catch (e) {
          return Left(UnknownFailure(message: 'Failed to parse response: $e'));
        }
      },
    );
  }
}