import 'package:fpdart/fpdart.dart';
import 'package:software_lab/core/network/api_client.dart';
import 'package:software_lab/core/network/api_constants.dart';
import 'package:software_lab/core/network/failures.dart';
import 'package:software_lab/features/login/data/models/login_model.dart';

class LoginRemoteDataSource {
  final ApiClient _apiClient;

  const LoginRemoteDataSource(this._apiClient);

  Future<Either<Failure, LoginResponseModel>> login(
    LoginRequestModel request,
  ) async {
    final result = await _apiClient.post(
      ApiConstants.login,
      data: request.toJson(),
    );

    return result.fold(
      (failure) => Left(failure),
      (response) {
        try {
          final model = LoginResponseModel.fromJson(response.data);
          return Right(model);
        } catch (e) {
          return Left(UnknownFailure(message: 'Failed to parse response: $e'));
        }
      },
    );
  }
}