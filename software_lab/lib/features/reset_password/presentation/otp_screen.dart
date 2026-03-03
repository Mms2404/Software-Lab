import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:software_lab/core/constants/app_colors.dart';
import 'package:software_lab/core/theme/app_text_styles.dart';
import 'package:software_lab/core/widgets/app_buttons.dart';
import 'package:software_lab/core/widgets/app_logo.dart';
import 'package:software_lab/core/widgets/app_notification.dart';
import 'package:software_lab/features/reset_password/data/models/password_reset_request_models.dart';
import 'package:software_lab/features/reset_password/presentation/bloc/password_reset_bloc.dart';
import 'package:software_lab/features/reset_password/presentation/bloc/password_reset_event.dart';
import 'package:software_lab/features/reset_password/presentation/bloc/password_reset_state.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  String get _otp => _controllers.map((c) => c.text).join();

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PasswordResetBloc, PasswordResetState>(
      listener: (context, state) {
        switch (state) {
          case OtpVerified(:final entity):
            AppNotification.success(context, entity.message);
            context.push("/reset-password");
          case PasswordResetFailure(:final failure):
            AppNotification.error(context, failure.message);
          case _:
            break;
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFEDE6E4),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
            child: Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppLogo(),
                  SizedBox(height: 50.h),
                  Text("Verify OTP", style: AppTextStyles.title),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Text("Remember your password? ",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.logo
                          )),
                      GestureDetector(
                        onTap: () => context.go("/login"),
                        child:
                            Text("Login", style: AppTextStyles.highlightedClue),
                      ),
                    ],
                  ),
                  SizedBox(height: 40.h),

                  /// OTP INPUT FIELDS
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(6, (index) {
                      return SizedBox(
                        width: 48.w,
                        height: 55.h,
                        child: TextField(
                          controller: _controllers[index],
                          focusNode: _focusNodes[index],
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: InputDecoration(
                            counterText: '',
                            filled: true,
                            fillColor:
                                AppColors.lightText.withValues(alpha: 0.1),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty && index < 5) {
                              _focusNodes[index + 1].requestFocus();
                            } else if (value.isEmpty && index > 0) {
                              _focusNodes[index - 1].requestFocus();
                            }
                          },
                        ),
                      );
                    }),
                  ),

                  SizedBox(height: 40.h),

                  AppButtons.full(
                    text: state is PasswordResetLoading
                        ? "Verifying..."
                        : "Submit",
                    onPressed: () {
                      if (state is PasswordResetLoading) return;

                      if (_otp.length < 6) {
                        AppNotification.warning(
                            context, "Please enter the complete OTP");
                        return;
                      }

                      context.read<PasswordResetBloc>().add(
                            OtpVerificationSubmitted(
                              VerifyOtpRequestModel(otp: _otp),
                            ),
                          );
                    },
                  ),

                  SizedBox(height: 20.h),

                  Center(
                    child: GestureDetector(
                      onTap: () {
                        // TODO: Resend OTP - call ForgotPasswordSubmitted again
                      },
                      child: Text(
                        "Resend Code",
                        style: AppTextStyles.highlightedClue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}