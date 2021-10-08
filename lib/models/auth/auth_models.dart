import 'dart:convert';

class AuthData{
  String email;
  String password;

  AuthData({
    this.email,
    this.password
  });

  String authPayload () {
    return json.encode({
      'email': this.email,
      'password': this.password,
    });
  }

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
  };
}

class UserProfile {
  final bool success;
  final String firstName;
  final String lastName;
  final String email;
  final String jobTitle;
  final String companyName;
  final String companyWebsiteUrl;
  final List<dynamic> integrations;

  UserProfile({
    this.success,
    this.firstName,
    this.lastName,
    this.email,
    this.jobTitle,
    this.companyName,
    this.companyWebsiteUrl,
    this.integrations
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    success: json['success'],
    firstName: json['firstName'],
    lastName: json['lastName'],
    email: json['email'],
    jobTitle: json['jobTitle'],
    companyName: json['companyName'],
    companyWebsiteUrl: json['companyWebsiteUrl'],
    integrations: json['integrations'],
  );


  Map<String, dynamic> toJson() => {
    'success': success,
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
    'jobTitle': jobTitle,
    'companyName': companyName,
    'companyWebsiteUrl': companyWebsiteUrl,
    'integrations': integrations,
  };
}