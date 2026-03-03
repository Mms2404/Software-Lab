import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:software_lab/features/reset_password/data/repositories/password_reset_repository.dart';
import 'package:software_lab/features/reset_password/presentation/bloc/password_reset_bloc.dart';
import 'package:software_lab/features/reset_password/presentation/bloc/password_reset_event.dart';

class PasswordResetBloc extends Bloc<PasswordResetEvent, PasswordResetState> {
  final PasswordResetRepository _repository;

  String? _resetToken;
  String? get resetToken => _resetToken;

  PasswordResetBloc(this._repository) : super(const PasswordResetInitial()) {
    on<ForgotPasswordSubmitted>(_onForgotPassword);
    on<OtpVerificationSubmitted>(_onVerifyOtp);
    on<ResetPasswordSubmitted>(_onResetPassword);
  }

  Future<void> _onForgotPassword(
    ForgotPasswordSubmitted event,
    Emitter<PasswordResetState> emit,
  ) async {
    emit(const PasswordResetLoading());

    final result = await _repository.forgotPassword(event.request);

    result.fold(
      (failure) => emit(PasswordResetFailure(failure)),
      (entity) => emit(OtpSentSuccess(entity)),
    );
  }

  Future<void> _onVerifyOtp(
    OtpVerificationSubmitted event,
    Emitter<PasswordResetState> emit,
  ) async {
    emit(const PasswordResetLoading());

    final result = await _repository.verifyOtp(event.request);

    result.fold(
      (failure) => emit(PasswordResetFailure(failure)),
      (entity) {
        _resetToken = entity.token;
        emit(OtpVerified(entity));
      },
    );
  }

  Future<void> _onResetPassword(
    ResetPasswordSubmitted event,
    Emitter<PasswordResetState> emit,
  ) async {
    emit(const PasswordResetLoading());

    final result = await _repository.resetPassword(event.request);

    result.fold(
      (failure) => emit(PasswordResetFailure(failure)),
      (entity) => emit(PasswordResetSuccess(entity)),
    );
  }
}