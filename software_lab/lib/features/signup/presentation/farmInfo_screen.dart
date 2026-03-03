import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:software_lab/core/constants/app_colors.dart';
import 'package:software_lab/core/theme/app_text_styles.dart';
import 'package:software_lab/core/widgets/app_buttons.dart';
import 'package:software_lab/core/widgets/app_dropdown.dart';
import 'package:software_lab/core/widgets/app_logo.dart';
import 'package:software_lab/core/widgets/app_notification.dart';
import 'package:software_lab/core/widgets/app_textfield.dart';
import 'package:software_lab/features/signup/presentation/helpers/signup_flow_data.dart';

class FarmInfoScreen extends StatefulWidget {
  const FarmInfoScreen({super.key});

  @override
  State<FarmInfoScreen> createState() => _FarmInfoScreenState();
}

class _FarmInfoScreenState extends State<FarmInfoScreen> {
 final states = [
  "Goa",
  "Texas", 
  "Lima",
   "Oslo", 
  "Bath", 
  "Ceará", 
  "Kobe", 
  "Zurich", 
  "Kerala", 
 "Bayern"
 ];

  final _formKey = GlobalKey<FormState>();
  late final TextEditingController busnamecontroller;
  late final TextEditingController informalcontroller;
  late final TextEditingController addresscontroller;
  late final TextEditingController citycontroller;
  late final TextEditingController zipcodecontroller;

  String? selectedState;

  @override
  void initState() {
    super.initState();
    busnamecontroller = TextEditingController();
    informalcontroller = TextEditingController();
    addresscontroller = TextEditingController();
    citycontroller = TextEditingController();
    zipcodecontroller = TextEditingController();
  }

  @override
  void dispose() {
    busnamecontroller.dispose();
    informalcontroller.dispose();
    addresscontroller.dispose();
    citycontroller.dispose();
    zipcodecontroller.dispose();
    super.dispose();
  }

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
                const AppLogo(),
                SizedBox(height: 40.h),
                Text("Signup 2 of 4", style: AppTextStyles.clue),
                SizedBox(height: 6.h),
                Text("Farm Info", style: AppTextStyles.title),
                SizedBox(height: 30.h),
                AppTextField(
                  controller: busnamecontroller,
                  hintText: "Business Name",
                  validator: (v) =>
                      v == null || v.isEmpty ? "Business name required" : null,
                  prefixIcon: "assets/icons/tag.png",
                ),
                SizedBox(height: 20.h),
                AppTextField(
                  controller: informalcontroller,
                  hintText: "Informal Name",
                  prefixIcon: "assets/icons/smile.png",
                ),
                SizedBox(height: 20.h),
                AppTextField(
                  controller: addresscontroller,
                  hintText: "Address",
                  validator: (v) =>
                      v == null || v.isEmpty ? "Address required" : null,
                  prefixIcon: "assets/icons/home.png",
                ),
                SizedBox(height: 20.h),
                AppTextField(
                  controller: citycontroller,
                  hintText: "City",
                  validator: (v) =>
                      v == null || v.isEmpty ? "City required" : null,
                  prefixIcon: "assets/icons/location.png",
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    AppDropdown(
                      value: selectedState,
                      items: states
                          .map((state) => DropdownMenuItem<String>(
                                value: state,
                                child: Text(state),
                              ))
                          .toList(),
                      hintText: "State",
                      onChanged: (value) {
                        setState(() {
                          selectedState = value;
                        });
                      },
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      flex: 1,
                      child: AppTextField(
                        controller: zipcodecontroller,
                        hintText: "Zip Code",
                        validator: (v) =>
                            v == null || v.isEmpty ? "Zip code required" : null,
                        type: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 220.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 8.w),
                      child: GestureDetector(
                        onTap: () => context.pop(),
                        child: Image.asset(
                          "assets/icons/back.png",
                          width: 24.w,
                          height: 24.h,
                        ),
                      ),
                    ),
                    AppButtons.half(
                      backgroundColor: AppColors.primary,
                      text: "Continue",
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) return;

                        if (selectedState == null) {
                          AppNotification.warning(
                              context, "Please select a state");
                          return;
                        }

                        flow.businessName = busnamecontroller.text.trim();
                        flow.informalName = informalcontroller.text.trim();
                        flow.address = addresscontroller.text.trim();
                        flow.city = citycontroller.text.trim();
                        flow.state = selectedState!;
                        flow.zipCode =
                            int.parse(zipcodecontroller.text.trim());

                        context.push("/signup/verification", extra: flow);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}