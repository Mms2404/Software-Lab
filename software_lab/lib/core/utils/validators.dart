class AppValidators {

  // EMAIL VALIDATOR
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email is required";
    }

    final emailRegex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );

    if (!emailRegex.hasMatch(value.trim())) {
      return "Enter a valid email address";
    }

    return null;
  }

  // PHONE VALIDATOR (Indian format)
  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Phone number is required";
    }

    final phoneRegex = RegExp(r'^[6-9]\d{9}$');

    if (!phoneRegex.hasMatch(value.trim())) {
      return "Enter a valid 10-digit phone number";
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }

    if (value.length < 8) {
      return "Password must be at least 8 characters";
    }

    final passwordRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$',
    );

    if (!passwordRegex.hasMatch(value)) {
      return "Password must include uppercase, lowercase & number";
    }

    return null;
  }

  // CONFIRM PASSWORD VALIDATOR
  static String? validateConfirmPassword(
      String? value,
      String originalPassword,
      ) {
    if (value == null || value.isEmpty) {
      return "Please confirm your password";
    }

    if (value != originalPassword) {
      return "Passwords do not match";
    }

    return null;
  }
}