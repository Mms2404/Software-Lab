import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:software_lab/core/theme/app_text_styles.dart';
import 'package:software_lab/core/widgets/app_buttons.dart';
import 'package:software_lab/core/widgets/app_logo.dart';
import 'package:software_lab/core/widgets/app_notification.dart';
import 'package:software_lab/core/widgets/app_textfield.dart';
import 'package:software_lab/features/reset_password/data/models/password_reset_request_models.dart';
import 'package:software_lab/features/reset_password/presentation/bloc/password_reset_bloc.dart';
import 'package:software_lab/features/reset_password/presentation/bloc/password_reset_event.dart';
import 'package:software_lab/features/reset_password/presentation/bloc/password_reset_state.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late final TextEditingController phonecontroller;

  @override
  void initState() {
    super.initState();
    phonecontroller = TextEditingController();
  }

  @override
  void dispose() {
    phonecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PasswordResetBloc, PasswordResetState>(
      listener: (context, state) {
        switch (state) {
          case OtpSentSuccess(:final entity):
            AppNotification.success(context, entity.message);
            context.push("/otp");
          case PasswordResetFailure(:final failure):
            AppNotification.error(context, failure.message);
          case _:
            break;
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.only(top: 40.h, left: 20.w, right: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppLogo(),
                SizedBox(height: 80.h),
                Text("Forgot Password?", style: AppTextStyles.title),
                SizedBox(height: 15.h),
                Row(
                  children: [
                    Text("Remember your password? ",
                        style: AppTextStyles.clue),
                    GestureDetector(
                      onTap: () => context.go("/login"),
                      child: Text("Login",
                          style: AppTextStyles.highlightedClue,
                          textAlign: TextAlign.center),
                    ),
                  ],
                ),
                SizedBox(height: 60.h),
                AppTextField(
                  controller: phonecontroller,
                  hintText: "Phone Number",
                  type: TextInputType.phone,
                  prefixIcon: "assets/icons/phone.png",
                ),
                SizedBox(height: 30.h),
                AppButtons.full(
                  text: state is PasswordResetLoading
                      ? "Sending..."
                      : "Send Code",
                  onPressed: () {
                    if (state is PasswordResetLoading) return;

                    final phone = phonecontroller.text.trim();
                    if (phone.isEmpty) {
                      AppNotification.warning(
                          context, "Please enter your phone number");
                      return;
                    }

                    context.read<PasswordResetBloc>().add(
                          ForgotPasswordSubmitted(
                            ForgotPasswordRequestModel(mobile: phone),
                          ),
                        );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}