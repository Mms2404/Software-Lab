import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:software_lab/core/theme/app_text_styles.dart';
import 'package:software_lab/core/widgets/app_buttons.dart';
import 'package:software_lab/core/widgets/app_logo.dart';
import 'package:software_lab/core/widgets/app_textfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    TextEditingController emailcontroller = TextEditingController();
    TextEditingController passwordcontroller = TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 40.h, left: 20.w, right: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppLogo(),
              SizedBox(height: 80.h),
        
              Text(
                "Welcome Back!",
                style:AppTextStyles.title,
              ),
              SizedBox(height: 15.h),
              Row(
                children: [
                  Text("New here? ", style: AppTextStyles.clue),
                  GestureDetector(
                      onTap: () {
                        context.go("/signup");  
                      },
                    child: Text("Create account", style: AppTextStyles.highlightedClue, textAlign: TextAlign.center))
                ],
              ),
        
              SizedBox(height: 60.h),
        
              AppTextField(
                controller: emailcontroller, 
                hintText: "Email Address",
                prefixIcon: Image.asset("assets/icons/email.png"),
              ),
              SizedBox(height: 20.h),
              AppTextField(
                controller: passwordcontroller, 
                hintText: "Password",
                prefixIcon: Image.asset("assets/icons/password.png"),
                suffixText: "Forgot?",
                onSuffixTap: () {
                  context.go("/forgot-password");
                },
                obscureText: true,
              ),
        
              SizedBox(height: 40.h),
              AppButtons.full(
                text: "Login", 
                onPressed: () {
                  context.go("/home");
                }),
        
                SizedBox(height: 30.h),
                Center(child: Text("or  login with", style: AppTextStyles.mini,)),
                SizedBox(height: 30.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AppButtons.icon(
                      iconPath: "assets/icons/google.png", 
                      onPressed: () {
                      }),
                    AppButtons.icon(
                      iconPath: "assets/icons/apple.png", 
                      onPressed: () {
                      }),
                    AppButtons.icon(
                      iconPath: "assets/icons/facebook.png", 
                      onPressed: () {
                      }),
                  ],
                )
            ],
          ),
        ),
      )
    );
  }
}