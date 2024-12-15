part of 'sign_in_bloc.dart';

abstract class SignInEvent {
  const SignInEvent();
}

class SignInEventInit extends SignInEvent{
  String verificationCode;
  String verificationId;
  String phoneNumber;
  SignInEventInit({required this.verificationCode,required this.verificationId,required this.phoneNumber});
}

class SignInSentOTPEventInit extends SignInEvent{
  String phoneNumber;
  SignInSentOTPEventInit({required this.phoneNumber});
}



