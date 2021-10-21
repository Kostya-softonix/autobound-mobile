import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:autobound_mobile/helpers/api_helpers.dart';

import 'package:autobound_mobile/models/index.dart';

Future<Map<String, dynamic>> authResponse(AuthData authData) async {
  String url = apiUrl + 'auth/login';

  http.Response res = await http.post(
    url,
    headers: <String, String> {
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: authData.authPayload(),
  );

  Map<String, dynamic> resData = json.decode(res.body);

  return resData;
}


Future<UserProfile> userProfileResponse(String token) async {
  String url = apiUrl + 'userProfile';

  http.Response res = await http.get(
    url,
    headers: <String, String> {
      'Content-Type': 'application/json; charset=UTF-8',
      'auth': token,
    },
  );

  Map<String, dynamic> resData = json.decode(res.body);

  UserProfile userProfile = UserProfile.fromJson(resData);

  return userProfile;
}