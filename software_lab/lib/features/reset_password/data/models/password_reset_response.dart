import 'package:software_lab/features/reset_password/domain/entities/password_reset_entity.dart';

class PasswordResetResponseModel {
  final dynamic _success;
  final String message;
  final String? token;
  final String? isVerified;

  const PasswordResetResponseModel({
    required dynamic success,
    required this.message,
    this.token,
    this.isVerified,
  }) : _success = success;

  factory PasswordResetResponseModel.fromJson(Map<String, dynamic> json) {
    return PasswordResetResponseModel(
      success: json['success'],
      message: json['message'] as String,
      token: json['token'] as String?,
      isVerified: json['is_verified'] as String?,
    );
  }

  bool get isSuccess {
    if (_success is bool) return _success;
    if (_success is String) return _success == 'true';
    return false;
  }

  PasswordResetEntity toEntity() {
    return PasswordResetEntity(
      message: message,
      token: token,
      isVerified: isVerified == 'true',
    );
  }
}