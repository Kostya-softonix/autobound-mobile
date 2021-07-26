import 'dart:convert';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../models/trigger.dart';

class Auth with ChangeNotifier {
  static const apiUrl = 'https://dev.autobound.ai/api/';

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

  Future<bool> tryAutologin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData = json.decode(prefs.getString('userData')) as Map<String, Object>;

    _token = extractedUserData['token'];

    notifyListeners();
    return true;
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
      prefs.setString('userData', userData);

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

  // Campaigns
  List<Trigger> _triggers = [];

  List<Trigger> get triggers {
    return [..._triggers];
  }

  Future<void> fetchTriggers() async {
    final url = apiUrl + 'suggestedGroups/groupedByTrigger?limit=1000&offset=0';

    try {
      final res = await http.get(
        url,
        headers: <String, String> {
          'Content-Type': 'application/json; charset=UTF-8',
          'auth': '$token',
        },
      );

      final List<Trigger> fetchedTriggers = [];

      final extractedData = json.decode(res.body) as Map<String, dynamic>;
      print(extractedData['triggers']);

      if(extractedData != null) {
        extractedData['triggers'].forEach((trg) {
          fetchedTriggers.add(
            Trigger(
              id: trg['id'],
              name: trg['name'],
              contacts: trg['contacts'],
              score: trg['score'],
              groups: trg['groups'],
              campaigns: trg['campaigns'],
              companies: trg['companies'],
            )
          );
        });
      }
      _triggers = fetchedTriggers;

    } catch (error) {
      throw(error);
    }
  }
}