import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/widget/primary_button.dart';
import '../../../../../widget/primary_scaffold.dart';
import '../../../../../widget/primary_text_field.dart';
import '../../../../home_main/prensentation/pages/plugin_view_page.dart';
import '../../../data/repositories/auth_repository.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {

  SignInBloc() : super(const SignInStateStarted()) {
    on<SignInSentOTPEventInit>(_onSentOtp);
    on<SignInEventInit>(_onSignInInit);
  }

  Future<void> _onSentOtp(
      SignInSentOTPEventInit event, Emitter<SignInState> emit) async {
    final phoneNumber = event.phoneNumber;

    if (phoneNumber.isEmpty) {
      emit(SignInStateFailure(error: "Please enter the phone number"));
      return;
    }

    emit(const SignInStateLoading());

    try {
      final result = await AuthRepository().loginWithPhoneNumber(phoneNumber: phoneNumber);
      if (result["status"] == "success") {
        emit(SignInStateOTPSent(verificationId: result["verificationId"]));
      } else {
        emit(SignInStateFailure(error: result["errorMessage"]));
      }
    } catch (error) {
      emit(SignInStateFailure(error: error.toString()));
    }
  }

  Future<void> _onSignInInit(
      SignInEventInit event, Emitter<SignInState> emit) async {
    final phoneNumber = event.phoneNumber;
    final verificationCode = event.verificationCode;

    if (phoneNumber.isEmpty) {
      emit(SignInStateFailure(error: "Please enter the phone number"));
      return;
    } else if (verificationCode.isEmpty) {
      emit(SignInStateFailure(error: "Please enter the OTP"));
      return;
    }

    emit(const SignInStateLoading());

    try {
      final isVerified = await AuthRepository().verifyOtp(
        verificationCode: verificationCode,
        verificationId: event.verificationId,
      );

      if (isVerified) {
        emit(const SignInStateSuccess());
      } else {
        emit(SignInStateFailure(error: "Can't login"));
      }
    } catch (error) {
      emit(SignInStateFailure(error: error.toString()));
    }
  }
}
