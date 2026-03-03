import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:software_lab/core/network/api_client.dart';
import 'package:software_lab/features/home/home_screen.dart';
import 'package:software_lab/features/login/data/datasources/login_remote_datasource.dart';
import 'package:software_lab/features/login/domain/repositories/login_repository_impl.dart';
import 'package:software_lab/features/login/presentation/bloc/login_bloc.dart';
import 'package:software_lab/features/reset_password/presentation/forgotPassword_screen.dart';
import 'package:software_lab/features/login/presentation/login_screen.dart';
import 'package:software_lab/features/reset_password/presentation/otp_screen.dart';
import 'package:software_lab/features/reset_password/presentation/resetPassword_screen.dart';
import 'package:software_lab/features/onboarding/presentation/onboarding_screen.dart';
import 'package:software_lab/features/signup/data/datasources/signup_remote_datasource.dart';
import 'package:software_lab/features/signup/data/repositories/signup_repository_impl.dart';
import 'package:software_lab/features/signup/presentation/bloc/signup_bloc.dart';
import 'package:software_lab/features/signup/presentation/farmInfo_screen.dart';
import 'package:software_lab/features/signup/presentation/hours_screen.dart';
import 'package:software_lab/features/signup/presentation/signUp_confirmation_screen.dart';
import 'package:software_lab/features/signup/presentation/signUp_screen.dart';
import 'package:software_lab/features/signup/presentation/verification_screen.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      /// ONBOARDING
      GoRoute(path: '/', builder: (context, state) => const OnboardingScreen()),

      /// LOGIN
      GoRoute(
        path: '/login',
        builder: (context, state) => BlocProvider(
          create: (_) => LoginBloc(
            LoginRepositoryImpl(
              LoginRemoteDataSource(ApiClient()),
            ),
          ),
          child: const LoginScreen(),
        ),
      ),

      /// FORGOT PASSWORD / OTP / RESET
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: '/otp',
        builder: (context, state) => const OtpScreen(),
      ),
      GoRoute(
        path: '/reset-password',
        builder: (context, state) => const ResetPasswordScreen(),
      ),

      /// SIGNUP FLOW — each screen passes SignupFlowData via extra
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: '/signup/farm-info',
        builder: (context, state) => const FarmInfoScreen(),
      ),
      GoRoute(
        path: '/signup/verification',
        builder: (context, state) => const VerificationScreen(),
      ),
      GoRoute(
        path: '/signup/hours',
        builder: (context, state) => BlocProvider(
          create: (_) => SignupBloc(
            SignupRepositoryImpl(
              SignupRemoteDataSource(ApiClient()),
            ),
          ),
          child: const HoursScreen(),
        ),
      ),
      GoRoute(
        path: '/signup/confirmation',
        builder: (context, state) => const SignupConfirmationScreen(),
      ),

      /// HOME
      GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
    ],
  );
}