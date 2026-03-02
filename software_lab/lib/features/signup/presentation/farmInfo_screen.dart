import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:software_lab/core/constants/app_colors.dart';
import 'package:software_lab/core/theme/app_text_styles.dart';
import 'package:software_lab/core/widgets/app_buttons.dart';
import 'package:software_lab/core/widgets/app_dropdown.dart';
import 'package:software_lab/core/widgets/app_logo.dart';
import 'package:software_lab/core/widgets/app_textfield.dart';
import 'package:software_lab/features/signup/presentation/helpers/signup_flow_data.dart';

class FarmInfoScreen extends StatefulWidget {
  const FarmInfoScreen({super.key});

  @override
  State<FarmInfoScreen> createState() => _FarmInfoScreenState();
}

class _FarmInfoScreenState extends State<FarmInfoScreen> {

  final List<String> indianStates = [
  "Andhra Pradesh",
  "Arunachal Pradesh",
  "Assam",
  "Bihar",
  "Chhattisgarh",
  "Goa",
  "Gujarat",
  "Haryana",
  "Himachal Pradesh",
  "Jharkhand",
  "Karnataka",
  "Kerala",
  "Madhya Pradesh",
  "Maharashtra",
  "Manipur",
  "Meghalaya",
  "Mizoram",
  "Nagaland",
  "Odisha",
  "Punjab",
  "Rajasthan",
  "Sikkim",
  "Tamil Nadu",
  "Telangana",
  "Tripura",
  "Uttar Pradesh",
  "Uttarakhand",
  "West Bengal"
];


  final _formKey = GlobalKey<FormState>();
  TextEditingController busnamecontroller = TextEditingController();
  TextEditingController informalcontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  TextEditingController citycontroller = TextEditingController();
  TextEditingController zipcodecontroller = TextEditingController();

  String? selectedState;

  @override
  Widget build(BuildContext context) {
     final flow = GoRouterState.of(context).extra as SignupFlowData;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 40.h, left: 25.w, right: 25.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppLogo(),
                SizedBox(height: 40.h),
                    
                Text("Signup 2 of 4", style: AppTextStyles.clue,),
                SizedBox(height: 6.h),
                Text(
                  "Farm Info",
                  style:AppTextStyles.title,
                ),
                SizedBox(height: 30.h),
                    
                AppTextField(
                  controller: busnamecontroller, 
                  hintText: "Business Name",
                  validator: (v) => v == null || v.isEmpty ? "Business name required" : null,
                  prefixIcon: Image.asset("assets/icons/tag.png"),
                ),
                SizedBox(height: 20.h),
                AppTextField(
                  controller: informalcontroller, 
                  hintText: "Informal Name",
                  prefixIcon: Image.asset("assets/icons/smile.png"),
                ),
                SizedBox(height: 20.h),
                AppTextField(
                  controller: addresscontroller, 
                  hintText: "Address",
                  validator: (v) => v == null || v.isEmpty ? "Address required" : null,
                  prefixIcon: Image.asset("assets/icons/home.png"),
                ),
                SizedBox(height: 20.h),
                AppTextField(
                  controller: citycontroller, 
                  hintText: "City",
                  validator: (v) => v == null || v.isEmpty ? "City required" : null,
                  prefixIcon: Image.asset("assets/icons/location.png"),
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    AppDropdown(
                      value: selectedState, 
                      items: indianStates.map((state) =>
                          DropdownMenuItem<String>(
                            value: state,
                            child: Text(state))).toList(), 
                      hintText: "State", 
                      onChanged: (value) {
                        setState(() {
                          selectedState = value;
                        });
                      }),
                    SizedBox(width: 12.w),
                      Expanded(
                        flex: 1,
                        child: AppTextField(
                          controller: zipcodecontroller, 
                          hintText: "Zip Code",
                          validator: (v) => v == null || v.isEmpty ? "Zip code required" : null,
                          type: TextInputType.number,
                                           ),
                      ),
                  ],
                ),
                
                SizedBox(height: 180.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 8.w),
                      child: GestureDetector(
                        onTap: () {
                          context.pop();
                        },
                        child: Image.asset(
                          "assets/icons/back.png",
                          width: 24.w,
                          height: 24.h,
                          )),
                    ),
                
                    AppButtons.half(
                      backgroundColor: AppColors.primary,
                      text: "Continue",
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) return;

                        flow.businessName = busnamecontroller.text.trim();
                        flow.informalName = informalcontroller.text.trim();
                        flow.address = addresscontroller.text.trim();
                        flow.city = citycontroller.text.trim();
                        flow.state = selectedState!;
                        flow.zipCode = int.parse(zipcodecontroller.text.trim());

                        context.push("/signup/verification", extra: flow);
                      },
                    ),
                  ],
                )
                    
                  
              ],
            ),
          ),
        ),
      )
    );
  }
}