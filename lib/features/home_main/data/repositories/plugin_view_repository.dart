import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:my_app/features/home_main/data/models/last_login_model.dart';
import 'package:my_app/utiles/globals.dart' as globals;

class PluginViewRepository {
  static PluginViewRepository? _instance;

  factory PluginViewRepository() {
    return _instance ??= PluginViewRepository._internal();
  }

  PluginViewRepository._internal();

  static String getCurrentUserId() {
    return FirebaseAuth.instance.currentUser?.uid ?? '';
  }

  static final List<LastLoginModel> _lastLoginModelList = [];

  static Future<List<LastLoginModel>> getLastLoginModelList() async {
    final String userId = getCurrentUserId();
    _lastLoginModelList.clear();
    final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

    DatabaseEvent event = await databaseReference.child('users/$userId').once();

    DataSnapshot snapshot = event.snapshot;

    if (snapshot.value != null) {
      Map<dynamic, dynamic> usersData = snapshot.value as Map<dynamic, dynamic>;
      usersData.forEach((userId, userData) {
        Map<dynamic, dynamic> userMap = userData as Map<dynamic, dynamic>;
        LastLoginModel moneyViewModel = LastLoginModel.fromMap(userMap);
        _lastLoginModelList.add(moneyViewModel);
      });
      _lastLoginModelList.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    }
    return _lastLoginModelList;
  }

  static Future<void> postLastModelData({
    required Map<dynamic, dynamic> data,
  }) async {
    try {
      final String userId = getCurrentUserId();
      DatabaseReference newRef =
          FirebaseDatabase.instance.ref().child("users/$userId").push();
      await newRef.set(data);
    } catch (e) {
      rethrow;
    }
  }

  static Future<Map> getIpInfo() async{
    try {
      final response = await http.get(Uri.parse('https://ipinfo.io/json?token=${globals.ipInfoToken}'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {"ipAddress": data['ip'],"city": data['city']};
      } else {
        return {"ipAddress": globals.defaultIpAddress,"city": globals.defaultCity};
      }
    } catch (e) {
      return {"ipAddress": globals.defaultIpAddress,"city": globals.defaultCity};
    }
  }
}
