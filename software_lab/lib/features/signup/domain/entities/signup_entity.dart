class SignUpEntity {
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
  final String registrationProofPath;
  final Map<String, List<String>> businessHours;
  final String deviceToken;
  final String type;
  final String? socialId;

  SignUpEntity({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.password,
    required this.role,
    required this.businessName,
    required this.informalName,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.registrationProofPath,
    required this.businessHours,
    required this.deviceToken,
    required this.type,
    this.socialId,
  });
}