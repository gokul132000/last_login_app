import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthRepository {
  static AuthRepository? _instance;

  factory AuthRepository() {
    return _instance ??= AuthRepository._internal();
  }

  AuthRepository._internal();

  Future<Map> loginWithPhoneNumber({
    required String phoneNumber,
  }) async {
    Completer<Map> completer = Completer();

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber.contains("+") ? phoneNumber : "+91$phoneNumber",
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (FirebaseAuthException error) {
          completer.complete({
            "status": "failure",
            "errorMessage": 'Verification failed: ${error.message ?? "Unknown error"}'
          });
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          completer.complete({
            "status": "success",
            "verificationId": verificationId
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      completer.complete({
        "status": "failure",
        "errorMessage": 'Verification failed: ${e.message ?? "Unknown error"}'
      });
    } catch (e) {
      completer.complete({
        "status": "failure",
        "errorMessage": 'Unexpected error: $e'
      });
    }

    return completer.future;
  }


  Future<bool> verifyOtp({required String verificationCode,required String verificationId}) async {
    var isLogin =  await FirebaseAuth.instance.signInWithCredential(PhoneAuthProvider.credential(verificationId: verificationId, smsCode: verificationCode));
    return isLogin.user?.uid != null;
  }
}
