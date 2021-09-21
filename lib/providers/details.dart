import 'dart:convert';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../core/helpers.dart';
import '../models/general.dart';

class Details with ChangeNotifier {

  String _token = '';

  Map<String, dynamic> _suggestedGroup = {};

  Map<String, dynamic> get suggestedGroup {
    return _suggestedGroup;
  }

  SuggestedGroupCampaingnContact _suggestedGroupContact;

  SuggestedGroupCampaingnContact get suggestedGroupContact {
    return _suggestedGroupContact;
  }

  List<dynamic> _content;

  List<dynamic> get content {
    return _content;
  }

  SuggestedGroupCampaingnCompany _suggestedGroupCompany;

  SuggestedGroupCampaingnCompany get suggestedGroupCompany {
    return _suggestedGroupCompany;
  }

  String _insight = '';

  String get insight {
    return _insight;
  }

  String _insightId = '';

  String get insightId {
    return _insightId;
  }

  IsightInfo _insightInfo;

  IsightInfo get insightInfo {
    return _insightInfo;
  }


  Future<void> fetchInsight(String id, String token) async {

    final url = apiUrl + 'suggestedGroups/insight/$id';
    // print(id);

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

      print('Insight data extracted');

      if(extractedData == null) {
        print('Extracted by trigger null');
        return;
      }

      print(extractedData);

      final insightInfo = extractedData['insight'];
      final insightAditionalData = insightInfo['additional_data'];

      final confidence = double.parse(insightAditionalData['confidence']) * 100;

      final insightPayload = new IsightInfo(
        title: insightInfo['title'] != null ? insightInfo['title'] : 'Unknown',
        confidence: confidence != null ? confidence.toStringAsFixed(0) : 'Unknown',
        domain: insightInfo['domain'] != null ? insightInfo['domain'] : 'Unknown',
        url: insightInfo['url'] != null ? insightInfo['url'] : 'Unknown',
        articleSentence: insightAditionalData['article_sentence'] != null ? insightAditionalData['article_sentence'] : 'Unknown',
        signalDate: insightInfo['found_at'] != null ? formatedDate(insightInfo['found_at']) : 'Unknown',
        financingType: insightAditionalData['financing_type'] != null ? insightAditionalData['financing_type'] : 'Unknown',
        financingRound: insightAditionalData['funding_round'] != null ? insightAditionalData['funding_round'] : 'Unknown',
        signalType: insightInfo['type'] != null ? insightInfo['type'] : 'Unknown',
        financingTypeTags: insightAditionalData['financing_type_tags'] != null
          ? insightAditionalData['financing_type_tags'].toList().join(",")
          : 'Unknown'
      );

      _insightInfo = insightPayload;

      print(insightPayload.toMap());

      notifyListeners();

    } catch (error) {
      throw(error);
    }
  }


  Future<void> fetchSuggestedGroup(String id, String token) async {
    _token = token;
    final url = apiUrl + 'suggestedGroups/$id';
    // print(id);

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
      // print(extractedData);
      print('Suggested group data extracted');



      if(extractedData == null) {
        print('Extracted by trigger null');
        return;
      }


      // print(extractedData['suggestedGroup']);

      final Map<String, dynamic> sg = extractedData['suggestedGroup'];
      _suggestedGroup = sg;

      _content = sg['content'];

      final dataPathContact = extractedData['suggestedGroup']['suggestedCampaigns'][0]['contact'];

      final contact = new SuggestedGroupCampaingnContact(
        email: dataPathContact['email'] != null ? dataPathContact['email'] : 'Unknown',
        department: dataPathContact['department'] != null ? dataPathContact['department'] : 'Unknown',
        externalCreatedAt: dataPathContact['externalCreatedAt'] != null ? formatedDate(dataPathContact['externalCreatedAt']) : 'Unknown',
        externalDeletedAt: dataPathContact['externalDeletedAt'] != null ? formatedDate(dataPathContact['externalDeletedAt']) : 'Unknown',
        firstName: dataPathContact['firstName'] != null ? dataPathContact['firstName'] : 'Unknown',
        fullName: dataPathContact['fullName'] != null ? dataPathContact['fullName'] : 'Unknown',
        lastActivityAt: dataPathContact['lastActivityAt'] != null ? formatedDate(dataPathContact['lastActivityAt']) : 'Unknown',
        lastCampaignStartedAt: dataPathContact['lastCampaignStartedAt'] != null ? formatedDate(dataPathContact['lastCampaignStartedAt']) : 'Unknown',
        lastName: dataPathContact['lastName'] != null ? dataPathContact['lastName'] : 'Unknown',
        mobilePhoneNumber: dataPathContact['mobilePhoneNumber'] != null ? dataPathContact['mobilePhoneNumber'] : 'Unknown',
        phoneNumber: dataPathContact['phoneNumber'] != null ? dataPathContact['phoneNumber'] : 'Unknown',
        title: dataPathContact['title'] != null ? dataPathContact['title'] : 'Unknown',
        id: dataPathContact['id'],
      );

      _suggestedGroupContact = contact;

      final dataPathCompany = extractedData['suggestedGroup']['suggestedCampaigns'][0]['company'];

      final company = new SuggestedGroupCampaingnCompany(
        id: dataPathCompany['id'],
        name: dataPathCompany['name'] != null ? dataPathCompany['name'] : 'Unknown',
        externalId: dataPathCompany['externalId'] != null ? dataPathCompany['externalId'] : 'Unknown',
        industry: dataPathCompany['industry'] != null ? dataPathCompany['industry'] : 'Unknown',
        metaCompany: dataPathCompany['metaCompany'] != null ? dataPathCompany['metaCompany'] : 'Unknown',
        websiteUrl: dataPathCompany['websiteUrl'] != null ? dataPathCompany['websiteUrl'] : 'Unknown',
      );

      _suggestedGroupCompany = company;

      _insight = sg['suggestedCampaigns'][0]['type'];

      print('Inside checked');

      if(_insight == 'insight') {
        _insightId = sg['suggestedCampaigns'][0]['insight'];

        final String insId = sg['suggestedCampaigns'][0]['insight'];
        await fetchInsight(insId, _token);

      }


      notifyListeners();
      _isLoading = false;

    } catch (error) {
      throw(error);
    }
  }

  bool _isLoading = false;

  bool get isLoading {
    return _isLoading;
  }


}
