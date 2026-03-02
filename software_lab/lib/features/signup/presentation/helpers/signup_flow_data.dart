import 'package:software_lab/features/signup/domain/entities/signup_entity.dart';

class SignupFlowData {
  // Step 1
  String? fullName;
  String? email;
  String? phone;
  String? password;

  // Step 2
  String? businessName;
  String? informalName;
  String? address;
  String? city;
  String? state;
  int? zipCode;

  // Step 3
  String? registrationProofPath;

  // Step 4
  Map<String, List<String>> businessHours = {};


  SignUpEntity toEntity(){
    return SignUpEntity(
      fullName: fullName!, 
      email: email!, 
      phone: phone!,
      password: password!,
      role: "farmer",
      businessName: businessName!, 
      informalName: informalName!, 
      address: address!, 
      city: city!, 
      state: state!, 
      zipCode: zipCode!, 
      registrationProofPath: registrationProofPath!, 
      businessHours: businessHours, 
      deviceToken: "", 
      type: "email/facebook/google/apple"
      );
  }
}