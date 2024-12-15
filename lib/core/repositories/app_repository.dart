import 'package:firebase_auth/firebase_auth.dart';

class AppRepository {
  static AppRepository? _instance;

  factory AppRepository() {
    _instance ??= AppRepository._internal();
    return _instance!;
  }
  AppRepository._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> checkUserStatus() async {
    User? user = _auth.currentUser;
    return user != null;
  }

  Future<void> logout() async {
    _auth.signOut();
  }
}