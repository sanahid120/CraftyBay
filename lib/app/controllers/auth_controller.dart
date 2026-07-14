import 'dart:convert';

import 'package:craftybay/features/auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  static UserModel? userModel;
  static String? token;

  static const String tokenKey = "token";
  static const String userKey = "user";

  static Future<void> saveUserData(UserModel userData, String newToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(userKey, jsonEncode(userData.toJson()));
    await prefs.setString(tokenKey, newToken);

    userModel = userData;
    token = newToken;
  }

  static Future<void> removeUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(userKey);
    await prefs.remove(tokenKey);
    userModel = null;
    token = null;
  }

  static Future<void> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userModel = UserModel.fromJson(jsonDecode(prefs.getString(userKey)!));
    token = prefs.getString(tokenKey);
  }


  static Future<bool> isUserLoggedIn()  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(tokenKey);

  }
}
