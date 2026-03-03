import 'package:software_lab/features/signup/data/models/business_hour_model.dart';
import 'package:software_lab/features/signup/data/models/signup_request_model.dart';

class SignupFlowData {
  // Step 1: Personal info
  String fullName = '';
  String email = '';
  String phone = '';
  String password = '';

  // Step 2: Farm info
  String businessName = '';
  String informalName = '';
  String address = '';
  String city = '';
  String state = '';
  int zipCode = 0;

  // Step 3: Verification
  String? registrationProofPath;

  // Step 4: Business hours
  Map<String, List<String>> businessHours = {};

  SignupRequestModel toRequestModel() {
    return SignupRequestModel(
      fullName: fullName,
      email: email,
      phone: phone,
      password: password,
      businessName: businessName,
      informalName: informalName,
      address: address,
      city: city,
      state: state,
      zipCode: zipCode,
      registrationProofPath: registrationProofPath,
      businessHours: BusinessHoursModel(hours: businessHours),
    );
  }
}