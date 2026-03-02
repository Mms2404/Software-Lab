import 'package:software_lab/core/network/api_client.dart';
import 'package:software_lab/core/network/api_constants.dart';
import '../models/signup_model.dart';

class AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSource(this.apiClient);

  Future<String> signup(SignupModel model) async {
    final formData = await model.toFormData();

    final response = await apiClient.postFormData(
      ApiConstants.register,
      formData: formData,
    );

    final data = response.data;

    if (data["success"] == "true") {
      return data["token"];
    } else {
      throw Exception(data["message"]);
    }
  }
}