import 'dart:convert';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../core/api_helpers.dart';

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

  Future<void> tryAutologin() async {
    final prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey('userProfile')) {
      return false;
    }

    final extractedUserData = json.decode(prefs.getString('userProfile')) as Map<String, Object>;

    print('token from prefs');
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


  Future<String> authentication(String email, String password) async {
    final  url = apiUrl + 'auth/login';

    try {
      final body = json.encode({
        'email': email,
        'password': password,
      });

      final res = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body,
      );

      final resData = json.decode(res.body);
      print(resData);

      if (resData['error'] != null) return resData['error']['message'];

      _token = resData['token'];

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': _token,
          'email': email,
          'password': password
        }
      );
      prefs.setString('userProfile', userData);

      await getUserProfile(_token);

      notifyListeners();

      return 'success';

    } catch (error) {
      throw error;
    }
  }

  Future<void> logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    _token = null;
    notifyListeners();
  }

  // User Profile
  Map<String, dynamic> userProfile = {};

  Future<bool> getUserProfile (String prefsToken) async {
    final url = apiUrl + 'userProfile';
    try {
      final res = await http.get(
        url,
        headers: <String, String> {
          'Content-Type': 'application/json; charset=UTF-8',
          'auth': prefsToken,
        },
      );

      // final extractedData = json.decode(res.body) as Map<String, dynamic>;
      userProfile = json.decode(res.body) as Map<String, dynamic>;
      print('userProfile response');
      print(userProfile);
      notifyListeners();

      final bool isSuccess = userProfile['success'];
      print(isSuccess);
      return isSuccess;

    } catch(error) {
      print(error);
      return false;
    }
  }

}