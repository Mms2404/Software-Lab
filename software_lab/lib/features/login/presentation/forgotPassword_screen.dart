import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:software_lab/core/theme/app_text_styles.dart';
import 'package:software_lab/core/widgets/app_buttons.dart';
import 'package:software_lab/core/widgets/app_logo.dart';
import 'package:software_lab/core/widgets/app_textfield.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {

    TextEditingController phonecontroller = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 40.h, left: 20.w, right: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppLogo(),
            SizedBox(height: 80.h),

            Text(
              "Forgot Password?",
              style:AppTextStyles.title,
            ),
            SizedBox(height: 15.h),
            Row(
              children: [
                Text("Remember your password? ", style: AppTextStyles.clue),
                GestureDetector(
                    onTap: () {
                      context.go("/login");  
                    },
                  child: Text("Login", style: AppTextStyles.highlightedClue, textAlign: TextAlign.center))
              ],
            ),

            SizedBox(height: 60.h),

            AppTextField(
              controller: phonecontroller, 
              hintText: "Phone Number",
              type: TextInputType.phone,
              prefixIcon: Image.asset("assets/icons/phone.png"),
            ),
            SizedBox(height: 30.h),

            AppButtons.full(
              text: "Send Code", 
              onPressed: () {
                context.go("/home");
              }),
              
          ],
        ),
      )
    );
  }
}