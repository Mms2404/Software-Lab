import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:software_lab/core/theme/app_text_styles.dart';
import 'package:software_lab/core/utils/validators.dart';
import 'package:software_lab/core/widgets/app_buttons.dart';
import 'package:software_lab/core/widgets/app_logo.dart';
import 'package:software_lab/core/widgets/app_notification.dart';
import 'package:software_lab/core/widgets/app_textfield.dart';
import 'package:software_lab/features/login/data/models/login_model.dart';
import 'package:software_lab/features/login/presentation/bloc/login_bloc.dart';
import 'package:software_lab/features/login/presentation/bloc/login_event.dart';
import 'package:software_lab/features/login/presentation/bloc/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        switch (state) {
          case LoginSuccess(:final entity):
            AppNotification.success(context, entity.message);
            context.go('/home');
          case LoginFailure(:final failure):
            AppNotification.error(context, failure.message);
          case _:
            break;
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 40.h, left: 20.w, right: 20.w),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppLogo(),
                    SizedBox(height: 80.h),
                    Text(
                      "Welcome Back!",
                      style: AppTextStyles.title,
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      children: [
                        Text("New here? ", style: AppTextStyles.clue),
                        GestureDetector(
                          onTap: () => context.go("/signup"),
                          child: Text(
                            "Create account",
                            style: AppTextStyles.highlightedClue,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 60.h),
                    AppTextField(
                      controller: emailController,
                      hintText: "Email Address",
                      prefixIcon: "assets/icons/email.png",
                      validator: AppValidators.validateEmail,
                    ),
                    SizedBox(height: 20.h),
                    AppTextField(
                      controller: passwordController,
                      hintText: "Password",
                      prefixIcon: "assets/icons/password.png",
                      obscureText: true,
                      suffixText: "Forgot?",
                      onSuffixTap: () {
                        context.push("/forgot-password");
                      },
                    ),
                    SizedBox(height: 40.h),
                    AppButtons.full(
                      text: state is LoginLoading
                          ? "Authenticating .."
                          : "Login",
                      onPressed: () {
                        if (state is LoginLoading) return;
                        if (_formKey.currentState!.validate()) {
                          _login(context);
                        }
                      },
                    ),
                    SizedBox(height: 30.h),
                    Center(
                      child: Text(
                        "or login with",
                        style: AppTextStyles.mini,
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AppButtons.icon(
                          iconPath: "assets/icons/google.png",
                          onPressed: () => _socialLogin(context, "google"),
                        ),
                        AppButtons.icon(
                          iconPath: "assets/icons/apple.png",
                          onPressed: () => _socialLogin(context, "apple"),
                        ),
                        AppButtons.icon(
                          iconPath: "assets/icons/facebook.png",
                          onPressed: () => _socialLogin(context, "facebook"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _login(BuildContext context) {
    context.read<LoginBloc>().add(
      LoginSubmitted(
        LoginRequestModel(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          deviceToken:  "0imfnc8mVLWwsAawjYr4Rx-Af50DDqtlx",
        ),
      ),
    );
  }

  void _socialLogin(BuildContext context, String type) {
    context.read<LoginBloc>().add(
      LoginSubmitted(
        LoginRequestModel(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          deviceToken:  "0imfnc8mVLWwsAawjYr4Rx-Af50DDqtlx",
          type: type,
          socialId: "0imfnc8mVLWwsAawjYr4Rx-Af50DDqtlx",
        ),
      ),
    );
  }
}