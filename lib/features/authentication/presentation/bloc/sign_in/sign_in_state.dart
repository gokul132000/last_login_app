part of 'sign_in_bloc.dart';

abstract class SignInState {
  const SignInState();
}

class SignInStateStarted extends SignInState{
  const SignInStateStarted();
}

class SignInStateOTPSent extends SignInState{
  String verificationId;
  SignInStateOTPSent({required this.verificationId});
}

class SignInStateLoading extends SignInState{
  const SignInStateLoading();
}

class SignInStateSuccess extends SignInState{
  const SignInStateSuccess();
}

class SignInStateFailure extends SignInState{
  final String error;
  SignInStateFailure({required this.error});
}




