import 'dart:convert';
import 'dart:async';
import 'package:flutter/widgets.dart';

import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _token;

  String get token {
    if (_token != null) {
      return _token;
    } else {
      return null;
    }
  }

  static const baseUrl = 'https://dev.autobound.ai/api/auth/login';

  Future<String> authentication(String email, String password) async {
    final  authUrl = baseUrl;

    try {
      final body = json.encode({
        'email': email,
        'password': password,
      });

      final res = await http.post(
        authUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body,
      );

      final resData = json.decode(res.body);
      print(resData);

      if (resData['error'] != null) return resData['error']['message'];
      _token = resData['token'];

      notifyListeners();

      return 'success';

    } catch (error) {
      throw error;
    }
  }



  void logOut() {
    _token = null;
    notifyListeners();
  }

}