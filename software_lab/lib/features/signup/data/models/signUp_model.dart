import 'package:dio/dio.dart';
import 'package:software_lab/features/signup/domain/entities/signup_entity.dart';


class SignupModel extends SignUpEntity {
  SignupModel({
    required super.fullName,
    required super.email,
    required super.phone,
    required super.password,
    required super.role,
    required super.businessName,
    required super.informalName,
    required super.address,
    required super.city,
    required super.state,
    required super.zipCode,
    required super.registrationProofPath,
    required super.businessHours,
    required super.deviceToken,
    required super.type,
    super.socialId,
  });

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      "full_name": fullName,
      "email": email,
      "phone": phone,
      "password": password,
      "role": role,
      "business_name": businessName,
      "informal_name": informalName,
      "address": address,
      "city": city,
      "state": state,
      "zip_code": zipCode,
      "registration_proof": await MultipartFile.fromFile(
        registrationProofPath,
        filename: registrationProofPath.split('/').last,
      ),
      "business_hours": businessHours,
      "device_token": deviceToken,
      "type": type,
      "social_id": socialId,
    });
  }

  factory SignupModel.fromEntity(SignUpEntity entity) {
    return SignupModel(
      fullName: entity.fullName,
      email: entity.email,
      phone: entity.phone,
      password: entity.password,
      role: entity.role,
      businessName: entity.businessName,
      informalName: entity.informalName,
      address: entity.address,
      city: entity.city,
      state: entity.state,
      zipCode: entity.zipCode,
      registrationProofPath: entity.registrationProofPath,
      businessHours: entity.businessHours,
      deviceToken: entity.deviceToken,
      type: entity.type,
      socialId: entity.socialId,
    );
  }
}