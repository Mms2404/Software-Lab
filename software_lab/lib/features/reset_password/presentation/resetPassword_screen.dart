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

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late final TextEditingController passwordcontroller;
  late final TextEditingController confirmpasswordcontroller;

  @override
  void initState() {
    super.initState();
    passwordcontroller = TextEditingController();
    confirmpasswordcontroller = TextEditingController();
  }

  @override
  void dispose() {
    passwordcontroller.dispose();
    confirmpasswordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PasswordResetBloc, PasswordResetState>(
      listener: (context, state) {
        switch (state) {
          case PasswordResetSuccess(:final entity):
            AppNotification.success(context, entity.message);
            context.go("/login");
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
                Text("Reset Password", style: AppTextStyles.title),
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
                  controller: passwordcontroller,
                  hintText: "New Password",
                  obscureText: true,
                  prefixIcon: "assets/icons/password.png",
                ),
                SizedBox(height: 20.h),
                AppTextField(
                  controller: confirmpasswordcontroller,
                  hintText: "Confirm Password",
                  prefixIcon: "assets/icons/password.png",
                  obscureText: true,
                ),
                SizedBox(height: 30.h),
                AppButtons.full(
                  text: state is PasswordResetLoading
                      ? "Resetting..."
                      : "Submit",
                  onPressed: () {
                    if (state is PasswordResetLoading) return;

                    final password = passwordcontroller.text;
                    final confirm = confirmpasswordcontroller.text;

                    if (password.isEmpty || confirm.isEmpty) {
                      AppNotification.warning(
                          context, "Please fill in both fields");
                      return;
                    }

                    if (password != confirm) {
                      AppNotification.error(
                          context, "Passwords do not match");
                      return;
                    }

                    final token =
                        context.read<PasswordResetBloc>().resetToken;

                    if (token == null) {
                      AppNotification.error(
                          context, "Session expired. Please start over.");
                      context.go("/forgot-password");
                      return;
                    }

                    context.read<PasswordResetBloc>().add(
                          ResetPasswordSubmitted(
                            ResetPasswordRequestModel(
                              token: token,
                              password: password,
                              confirmPassword: confirm,
                            ),
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