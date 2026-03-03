class ForgotPasswordRequestModel {
  final String mobile;

  const ForgotPasswordRequestModel({required this.mobile});

  Map<String, dynamic> toJson() => {'mobile': mobile};
}

class VerifyOtpRequestModel {
  final String otp;

  const VerifyOtpRequestModel({required this.otp});

  Map<String, dynamic> toJson() => {'otp': otp};
}

class ResetPasswordRequestModel {
  final String token;
  final String password;
  final String confirmPassword;

  const ResetPasswordRequestModel({
    required this.token,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() => {
        'token': token,
        'password': password,
        'cpassword': confirmPassword,
      };
}