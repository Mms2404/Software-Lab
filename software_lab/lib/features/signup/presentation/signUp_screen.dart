import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:software_lab/core/constants/app_colors.dart';
import 'package:software_lab/core/theme/app_text_styles.dart';
import 'package:software_lab/core/utils/validators.dart';
import 'package:software_lab/core/widgets/app_buttons.dart';
import 'package:software_lab/core/widgets/app_logo.dart';
import 'package:software_lab/core/widgets/app_textfield.dart';
import 'package:software_lab/features/signup/presentation/helpers/signup_flow_data.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController fullnamecontroller;
  late final TextEditingController emailcontroller;
  late final TextEditingController phonecontroller;
  late final TextEditingController passwordcontroller;
  late final TextEditingController confirmpasswordcontroller;

  @override
  void initState() {
    super.initState();
    fullnamecontroller = TextEditingController();
    emailcontroller = TextEditingController();
    phonecontroller = TextEditingController();
    passwordcontroller = TextEditingController();
    confirmpasswordcontroller = TextEditingController();
  }

  @override
  void dispose() {
    fullnamecontroller.dispose();
    emailcontroller.dispose();
    phonecontroller.dispose();
    passwordcontroller.dispose();
    confirmpasswordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                Text("Signup 1 of 4", style: AppTextStyles.clue),
                SizedBox(height: 6.h),
                Text("Welcome!", style: AppTextStyles.title),
                SizedBox(height: 30.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AppButtons.icon(
                      iconPath: "assets/icons/google.png",
                      onPressed: () {},
                    ),
                    AppButtons.icon(
                      iconPath: "assets/icons/apple.png",
                      onPressed: () {},
                    ),
                    AppButtons.icon(
                      iconPath: "assets/icons/facebook.png",
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
                Center(
                  child: Text("or signup with", style: AppTextStyles.mini),
                ),
                SizedBox(height: 30.h),
                AppTextField(
                  controller: fullnamecontroller,
                  validator: (v) =>
                      v == null || v.isEmpty ? "Full name is required" : null,
                  hintText: "Full Name",
                  prefixIcon: "assets/icons/person.png",
                ),
                SizedBox(height: 20.h),
                AppTextField(
                  controller: emailcontroller,
                  hintText: "Email Address",
                  validator: AppValidators.validateEmail,
                  prefixIcon: "assets/icons/email.png",
                ),
                SizedBox(height: 20.h),
                AppTextField(
                  controller: phonecontroller,
                  hintText: "Phone Number",
                  type: TextInputType.number,
                  validator: AppValidators.validatePhone,
                  prefixIcon: "assets/icons/phone.png",
                ),
                SizedBox(height: 20.h),
                AppTextField(
                  controller: passwordcontroller,
                  hintText: "Password",
                  validator: AppValidators.validatePassword,
                  prefixIcon: "assets/icons/password.png",
                  obscureText: true,
                ),
                SizedBox(height: 20.h),
                AppTextField(
                  controller: confirmpasswordcontroller,
                  hintText: "Confirm Password",
                  validator: (value) => AppValidators.validateConfirmPassword(
                      value, passwordcontroller.text),
                  prefixIcon: "assets/icons/password.png",
                  obscureText: true,
                ),
                SizedBox(height: 40.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => context.go("/login"),
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.w),
                        child: Text("Login", style: AppTextStyles.todo),
                      ),
                    ),
                    AppButtons.half(
                      backgroundColor: AppColors.primary,
                      text: "Continue",
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) return;

                        final flow = SignupFlowData()
                          ..fullName = fullnamecontroller.text.trim()
                          ..email = emailcontroller.text.trim()
                          ..phone = phonecontroller.text.trim()
                          ..password = passwordcontroller.text;

                        context.push("/signup/farm-info", extra: flow);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}