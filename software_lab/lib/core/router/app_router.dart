import 'package:go_router/go_router.dart';
import 'package:software_lab/features/login/presentation/forgotPassword_screen.dart';
import 'package:software_lab/features/login/presentation/login_screen.dart';
import 'package:software_lab/features/login/presentation/otp_screen.dart';
import 'package:software_lab/features/login/presentation/resetPassword_screen.dart';
import 'package:software_lab/features/onboarding/presentation/onboarding_screen.dart';
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
      GoRoute(
        path: '/',
        builder: (context, state) => const OnboardingScreen(),
      ),


      /// AUTH
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
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


      /// SIGNUP FLOW
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
        builder: (context, state) => const HoursScreen(),
      ),
      GoRoute(
        path: '/signup/confirmation',
        builder: (context, state) => const SignupConfirmationScreen(),
      ),
    ],
  );
}