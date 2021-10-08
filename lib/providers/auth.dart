import 'dart:convert';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:autobound_mobile/models/auth/auth_models.dart';
import 'package:autobound_mobile/services/auth_service.dart';

class Auth with ChangeNotifier {

  bool _isLoading = false;

  bool get isLoading {
    return _isLoading;
  }

  // Authentication
  String _token;

  String get token {
    if (_token != null) {
      return _token;
    } else {
      return null;
    }
  }

  bool get isAuth {
    return token != null;
  }


  Future<void> setTokenToSharedPreferences () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userData = json.encode({
      'token': _token,
    });

    prefs.setString('userProfile', userData);
  }

  Future<String> authentication(AuthData authData) async {
    try {
      Map<String, dynamic> resData = await authResponse(authData);

      if (resData['error'] != null) return resData['error']['message'];

      _token = resData['token'];

      print(_token);

      setTokenToSharedPreferences();

      await getUserProfile(_token);

      notifyListeners();

      return 'success';

    } catch (error) {
      throw error;
    }
  }

  // User Profile
  UserProfile userProfile;

  Future<bool> getUserProfile (String token) async {
    try {
      userProfile = await userProfileResponse(token);

      notifyListeners();
      return userProfile.success;

    } catch(error) {
      print(error);
      return false;

    }
  }

  // Autologin
  Future<void> tryAutologin() async {
    final prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey('userProfile')) return false;

    final extractedUserData = json.decode(prefs.getString('userProfile')) as Map<String, Object>;

    print(extractedUserData['token']);

    final isValid = await getUserProfile(extractedUserData['token']);

    if(isValid) {
      _token = extractedUserData['token'];
    } else {
      _token = null;
      prefs.clear();
    }
    notifyListeners();
  }


  Future<void> logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();

    _token = null;

    notifyListeners();
  }
}