

import 'package:software_lab/features/login/data/models/login_model.dart';

sealed class LoginEvent {
  const LoginEvent();
}

class LoginSubmitted extends LoginEvent {
  final LoginRequestModel request;

  const LoginSubmitted(this.request);
}