import 'package:software_lab/features/signup/data/models/business_hour_model.dart';

class SignupRequestModel {
  final String fullName;
  final String email;
  final String phone;
  final String password;
  final String role;
  final String businessName;
  final String informalName;
  final String address;
  final String city;
  final String state;
  final int zipCode;
  final String? registrationProofPath;
  final BusinessHoursModel businessHours;
  final String deviceToken;
  final String type;
  final String socialId;

  const SignupRequestModel({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.password,
    this.role = 'farmer',
    required this.businessName,
    required this.informalName,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
    this.registrationProofPath,
    required this.businessHours,
    this.deviceToken = '0imfnc8mVLWwsAawjYr4Rx-Af50DDqtlx',
    this.type = 'email',
    this.socialId = '0imfnc8mVLWwsAawjYr4Rx-Af50DDqtlx',
  });

  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'email': email,
      'phone': phone,
      'password': password,
      'role': role,
      'business_name': businessName,
      'informal_name': informalName,
      'address': address,
      'city': city,
      'state': state,
      'zip_code': zipCode,
      'registration_proof': registrationProofPath?.split('/').last ?? '',
      'business_hours': businessHours.toJson(),
      'device_token': deviceToken,
      'type': type,
      'social_id': socialId,
    };
  }
}