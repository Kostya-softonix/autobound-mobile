import 'dart:convert';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Contact {
  final String id;
  final String company;
  final String firstName;
  final String fullName;
  final String lastName;
  final String title;
  final String lastActivityAt;
  final String lastCampaignStartedAt;

  Contact({
    this.id,
    this.company,
    this.firstName,
    this.fullName,
    this.lastName,
    this.title,
    this.lastActivityAt,
    this.lastCampaignStartedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'company': company,
      'firstName': firstName,
      'fullName': fullName,
      'lastName': lastName,
      'title': title,
      'lastActivityAt': lastActivityAt,
      'lastCampaignStartedAt': lastCampaignStartedAt,
    };
  }
}

class Company {
  final String name;
  final String id;

  Company({
    this.name,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
    };
  }
}

class Campaign {
  final String id;
  final int score;
  final Map<String, dynamic> contact;
  final  String contactName;

  Campaign({
    this.id,
    this.score,
    this.contact,
    this.contactName
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'score': score,
      'contact': contact,
      'contactName': contactName
    };
  }
}

class Group {
  final String id;
  final int score;
  final List<Campaign> campaigns;

  Group({
    this.id,
    this.score,
    this.campaigns

  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'score': score,
      'campaigns': campaigns
    };
  }
}

class SelectedCampaign {
  final List<Group> groups;
  final List<Contact> contacts;
  final List<Company> companies;

  SelectedCampaign({
    this.groups,
    this.contacts,
    this.companies,
  });

  Map<String, dynamic> toMap() {
    return {
      'groups': groups,
      'contacts': contacts,
      'companies': companies
    };
  }
}

class Campaigns with ChangeNotifier {
  static const apiUrl = 'https://dev.autobound.ai/api/';

  bool _isLoading = false;

  bool get isLoading {
    return _isLoading;
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
    print('Trig Search Provider');
    print(searchValue);

    filterCampaign();
  }

  SelectedCampaign filteredCampaign = new SelectedCampaign(
    contacts: [],
    companies: [],
    groups: [],
  );

  void filterCampaign() {
    if(search.isEmpty) {
      print('Empty');
      filteredCampaign = selectedCampaign;
      notifyListeners();
    } else {
      print('Filtered');
      final List<Group> filteredGroups = [];

      campaingnGroups.forEach((group) {

        Group filteredGr = Group(
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
      filteredCampaign = filteredSC;

      notifyListeners();
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

  Future<void> fetchGroupsByTrigger(String id, String token) async {
    final url = apiUrl + 'suggestedGroups/byTrigger/$id';
    print(id);

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
        print('Extracted by trigger null');
        _campaingnContacts = [];
        _campaingnCompanies = [];
        _campaingnGroups = [];
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
              campaigns: (g['campaigns'] as List<dynamic>).map((item) => new Campaign(
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

      // search = '';
      filteredCampaign = selectedCampaign;

      notifyListeners();
      _isLoading = false;

    } catch (error) {
      throw(error);
    }

  }
}