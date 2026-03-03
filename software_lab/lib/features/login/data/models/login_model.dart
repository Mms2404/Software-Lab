import 'package:software_lab/features/login/domain/entities/login_entity.dart';

class LoginRequestModel {
  final String email;
  final String password;
  final String role;
  final String deviceToken;
  final String type;
  final String? socialId;

  const LoginRequestModel({
    required this.email,
    required this.password,
    this.role = 'farmer',
    required this.deviceToken,
    this.type = 'email',
    this.socialId,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'email': email,
      'password': password,
      'role': role,
      'device_token': deviceToken,
      'type': type,
    };

    if (type != 'email' && socialId != null) {
      map['social_id'] = socialId;
    }

    return map;
  }
}





class LoginResponseModel {
  final dynamic _success;
  final String message;
  final String? token;

  const LoginResponseModel({
    required dynamic success,
    required this.message,
    this.token,
  }) : _success = success;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
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

  LoginEntity toEntity() {
    return LoginEntity(
      token: token ?? '',
      message: message,
    );
  }
}