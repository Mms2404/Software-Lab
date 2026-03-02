import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:software_lab/core/constants/app_strings.dart';

class SignupConfirmationScreen extends StatefulWidget {
  const SignupConfirmationScreen({super.key});

  @override
  State<SignupConfirmationScreen> createState() => _SignupConfirmationScreenState();
}

class _SignupConfirmationScreenState extends State<SignupConfirmationScreen> {

   @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        context.go("/home");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Center(
          child: Column(
            children: [
              Image.asset("assets/icon/tick.png",
                 width: 120.w,
                 height: 80.h,
              ),
              SizedBox(height: 30.h,),
              Text(AppStrings.signupComplete)
          ],)
        ),
      ),
    );
  }
}