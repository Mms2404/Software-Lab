import 'package:software_lab/features/signup/data/models/signup_request_model.dart';

sealed class SignupEvent {
  const SignupEvent();
}

class SignupSubmitted extends SignupEvent {
  final SignupRequestModel request;

  const SignupSubmitted(this.request);
}