import 'dart:convert';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../models/trigger.dart';
import '../models/general.dart';


class Auth with ChangeNotifier {
  static const apiUrl = 'https://dev.autobound.ai/api/';

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

      final extractedData = json.decode(res.body) as Map<String, dynamic>;
      print('userProfile response');

      print(extractedData);
      userProfile = extractedData;
      final bool isSuccess = extractedData['success'];
      print(isSuccess);
      notifyListeners();
      return isSuccess;

    } catch(error) {
      print(error);
      return false;
    }
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
      // print(extractedData['triggers']);

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

      print(_triggers);

      notifyListeners();

    } catch (error) {
      throw(error);
    }
  }

  List<Contact> _campaingnContacts = [];
  List<Company> _campaingnCompanies = [];
  List<Group> _campaingnGroups = [];

  List<Group> get campaingnGroups {
    return _campaingnGroups;
  }

  SelectedCampaign get selectedCampaign {
    return SelectedCampaign(
      contacts: _campaingnContacts,
      companies: _campaingnCompanies,
      groups: _campaingnGroups,
    );
  }

  String search = '';

  void setSearchContent(String searchValue) {
    search = searchValue;
  }

  SelectedCampaign get filteredCampaign {
    if(search.isEmpty) {
      return selectedCampaign;
    } else {
      // return selectedCampaign.toMap()['groups'].where((group) => group.campaigns.where((camp) => camp.contact['firstName'] == search) as SelectedCampaign);

      final List<Group> filteredGroups = [];

      campaingnGroups.forEach((group) {

        var filteredGr = Group(
          id: group.id,
          score: group.score,
          campaigns: group.campaigns.where((camp) => camp.contactName.toLowerCase().contains(search.toLowerCase())).toList()
        );

        print(filteredGr.campaigns);

        if(filteredGr.campaigns.length > 0) {
          filteredGroups.add(filteredGr);
        }
      });

      final filteredSC = SelectedCampaign(
        contacts: _campaingnContacts,
        companies: _campaingnCompanies,
        groups: filteredGroups,
      );
      return filteredSC;
    }
  }

  Map<String, dynamic> findContactById(String id) {
    Contact contact = _campaingnContacts.firstWhere((item) => item.id == id);

    return contact.toMap();
  }

  String findCompanyById(String id) {
    Company company = _campaingnCompanies.firstWhere((item) => item.id == id);

    return company.name;
  }



  Future<void> fetchGroupsByTrigger(String id) async {
    final url = apiUrl + 'suggestedGroups/byTrigger/$id';

    try {

      _isLoading = true;

      final res = await http.get(
        url,
        headers: <String, String> {
          'Content-Type': 'application/json; charset=UTF-8',
          'auth': '$token',
        },
      );

      final extractedData = json.decode(res.body) as Map<String, dynamic>;
      print(extractedData['contacts'].length);



      if(extractedData == null) {
        _campaingnContacts = [];
        return;
      }

      List<Contact> campContacts = [];
      if(extractedData['contacts'].length > 0) {
        extractedData['contacts'].forEach((c) {
          campContacts.add(
            Contact(
              id: c['id'],
              company: c['company'],
              firstName: c['firstName'],
              fullName: c['fullName'],
              lastName: c['lastName'],
              title: c['title'],
              lastActivityAt: c['lastActivityAt'],
              lastCampaignStartedAt: c['lastCampaignStartedAt'],
            )
          );
        });
      }
      _campaingnContacts = campContacts;

      List<Company> campCompanies = [];
      if(extractedData['companies'].length > 0) {
        extractedData['companies'].forEach((c) {
          campCompanies.add(
            Company(
              id: c['id'],
              name: c['name']
            )
          );
        });
      }
      _campaingnCompanies = campCompanies;

      List<Group> campGroups = [];
      if(extractedData['groups'].length > 0) {
        extractedData['groups'].forEach((g) {
          campGroups.add(
            Group(
              id: g['id'],
              score: g['score'],
              campaigns: (g['campaigns'] as List<dynamic>).map((item) => Campaign(
                id: item['id'],
                score: item['score'],
                contact: findContactById(item['contact']),
                contactName: findContactById(item['contact'])['fullName']
              ))
              .toList(),
            )
          );
        });
      }
      _campaingnGroups = campGroups;



      notifyListeners();

      _isLoading = false;

    } catch (error) {
      throw(error);
    }

  }

}