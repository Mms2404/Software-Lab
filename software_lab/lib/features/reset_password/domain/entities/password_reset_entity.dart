class PasswordResetEntity {
  final String message;
  final String? token;
  final bool? isVerified;

  const PasswordResetEntity({
    required this.message,
    this.token,
    this.isVerified,
  });
}