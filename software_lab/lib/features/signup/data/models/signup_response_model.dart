import 'package:software_lab/features/signup/domain/entities/signup_entity.dart';

class SignupResponseModel {
  final dynamic _success;
  final String message;
  final String? token;

  const SignupResponseModel({
    required dynamic success,
    required this.message,
    this.token,
  }) : _success = success;

  factory SignupResponseModel.fromJson(Map<String, dynamic> json) {
    return SignupResponseModel(
      success: json['success'],
      message: json['message'] as String,
      token: json['token'] as String?,
    );
  }

  bool get isSuccess {
    if (_success is bool) return _success;
    if (_success is String) return _success == 'true';
    return false;
  }

  SignupEntity toEntity() {
    return SignupEntity(
      token: token ?? '',
      message: message,
    );
  }
}