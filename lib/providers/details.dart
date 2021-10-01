import 'dart:convert';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../core/api_helpers.dart';
import '../core/helpers.dart';
import '../models/general.dart';

class Details with ChangeNotifier {

  bool _isLoading = false;

  bool get isLoading {
    return _isLoading;
  }

  Map<String, dynamic> _customFields = {};

  Map<String, dynamic> get customFields {
    return _customFields;
  }

  String _token = '';

  Map<String, dynamic> _suggestedGroup = {};

  Map<String, dynamic> get suggestedGroup {
    return _suggestedGroup;
  }

  SuggestedGroupCampaingnContact _suggestedGroupContact;

  SuggestedGroupCampaingnContact get suggestedGroupContact {
    return _suggestedGroupContact;
  }

  List<CustomEmailContent> _content;

  List<CustomEmailContent> get content {
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

      double checkAndConvertConfidence() {
        if(extractedData['insight'].containsKey('confidence')) {
          return double.parse(insightAditionalData['confidence']) * 100;
        } else {
          return 0;
        }
      }

      String checkAndConvertfinancingTypeTags() {
        if(extractedData['insight'].containsKey('financing_type_tags')) {
          return insightAditionalData['financing_type_tags'].toList().join(",");
        } else {
          return null;
        }
      }

      String checkAndGetData(String param) {
        if(extractedData['insight'].containsKey(param)) {
          return insightAditionalData[param];
        } else {
          return null;
        }
      }

      final insightPayload = new IsightInfo(
        title: insightInfo['title'] ?? 'Unknown',
        confidence: checkAndConvertConfidence() != null
          ? checkAndConvertConfidence().toStringAsFixed(0)
          : 'Unknown',
        domain: insightInfo['domain'] ?? 'Unknown',
        url: insightInfo['url'] ?? 'Unknown',
        articleSentence: checkAndGetData('article_sentence') ?? 'Unknown',
        signalDate: insightInfo['found_at']
          != null ? formatedDate(insightInfo['found_at'])
          : 'Unknown',
        financingType: checkAndGetData('financing_type') ?? 'Unknown',
        financingRound: checkAndGetData('funding_round') ?? 'Unknown',
        signalType: insightInfo['type'] ?? 'Unknown',
        financingTypeTags: checkAndConvertfinancingTypeTags() ?? 'Unknown'
      );

      _insightInfo = insightPayload;

      _isLoading = false;

      notifyListeners();

    } catch (error) {
      throw(error);
    }
  }

  Future<void> fetchCustomFields(List<String> ids, String token) async {
    final url = apiUrl + 'suggestedGroups/customFields';

    try {
      _isLoading = true;

      final res = await http.post(
        url,
        headers: <String, String> {
          'Content-Type': 'application/json; charset=UTF-8',
          'auth': '$token',
        },
        body: jsonEncode(<String, List<String>>{
          'ids': ids
        }
      ));

      final extractedData = json.decode(res.body) as Map<String, dynamic>;

      final String id = ids[0];
      print('Fields data extracted');
      print(extractedData['customFields'][id]);


      if(extractedData == null) {
        print('Extracted fields null');
        return;
      }

      _customFields = extractedData['customFields'][id];

      print('Custom fields');
      print(_customFields);

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
      print(extractedData);
      print('Suggested group data extracted');

      if(extractedData == null) {
        print('Extracted by trigger null');
        return;
      }

      // print(extractedData['suggestedGroup']);

      final Map<String, dynamic> sg = extractedData['suggestedGroup'];
      _suggestedGroup = sg;


      List<CustomEmailContent> listContent = [];

      if(sg['content'].length > 0) {
        sg['content'].forEach((c) {
          listContent.add(
            CustomEmailContent(
              paragraph: c['paragraph'],
              snippet: c['snippet'],
              logicSet: c['logicSet'],
              text: c['text'],
            )
          );
        });
      }
      _content = listContent;

      print('Content List provider');
      print(_content);

      final String customFieldsGroupId = sg['suggestedCampaigns'][0]['id'];

      await fetchCustomFields([customFieldsGroupId], token);

      final dataPathContact = extractedData['suggestedGroup']['suggestedCampaigns'][0]['contact'];

      final contact = new SuggestedGroupCampaingnContact(
        email: dataPathContact['email'] ?? 'Unknown',
        department: dataPathContact['department'] ?? 'Unknown',
        externalCreatedAt: dataPathContact['externalCreatedAt']
          != null ? formatedDate(dataPathContact['externalCreatedAt'])
          : 'Unknown',
        externalDeletedAt: dataPathContact['externalDeletedAt']
          != null ? formatedDate(dataPathContact['externalDeletedAt'])
          : 'Unknown',
        firstName: dataPathContact['firstName'] ?? 'Unknown',
        fullName: dataPathContact['fullName'] ?? 'Unknown',
        lastActivityAt: dataPathContact['lastActivityAt']
          != null ? formatedDate(dataPathContact['lastActivityAt'])
          : 'Unknown',
        lastCampaignStartedAt: dataPathContact['lastCampaignStartedAt']
          != null ? formatedDate(dataPathContact['lastCampaignStartedAt'])
          : 'Unknown',
        lastName: dataPathContact['lastName'] ?? 'Unknown',
        mobilePhoneNumber: dataPathContact['mobilePhoneNumber'] ?? 'Unknown',
        phoneNumber: dataPathContact['phoneNumber'] ?? 'Unknown',
        title: dataPathContact['title'] ?? 'Unknown',
        id: dataPathContact['id'],
      );

      _suggestedGroupContact = contact;

      final dataPathCompany = extractedData['suggestedGroup']['suggestedCampaigns'][0]['company'];

      final company = new SuggestedGroupCampaingnCompany(
        id: dataPathCompany['id'],
        name: dataPathCompany['name'] ?? 'Unknown',
        externalId: dataPathCompany['externalId'] ?? 'Unknown',
        industry: dataPathCompany['industry'] ?? 'Unknown',
        metaCompany: dataPathCompany['metaCompany'] ?? 'Unknown',
        websiteUrl: dataPathCompany['websiteUrl'] ?? 'Unknown',
      );

      _suggestedGroupCompany = company;

      _insight = sg['suggestedCampaigns'][0]['type'];

      if(_insight == 'insight') {
        _insightId = sg['suggestedCampaigns'][0]['insight'];

        final String insId = sg['suggestedCampaigns'][0]['insight'];
        await fetchInsight(insId, _token);
      }

      _isLoading = false;

      notifyListeners();

    } catch (error) {
      throw(error);
    }
  }

  Future<void> approveCampaign() async {
    print('Approve');
    final url = apiUrl + 'suggestedGroups/startCampaign';

    final String id = suggestedGroup['suggestedCampaigns'][0]['id'];
    final String subject = content[0].text;
    final String body = content[1].text + content[2].text + content[3].text + content[4].text + content[5].text;

    final List<JsonApprovePayload> payload = [
      JsonApprovePayload(id, body, subject),
    ];

    print(payload);

    String finalPayload = jsonEncode(payload);
    print(finalPayload);

    try {
      final res = await http.post(
        url,
        headers: <String, String> {
          'Content-Type': 'application/json; charset=UTF-8',
          'auth': _token,
        },
        body: finalPayload
      );

      final extractedData = json.decode(res.body) as Map<String, dynamic>;

      print('Approve data extracted');
      print(extractedData);

    } catch (error) {
      throw(error);
    }
  }

  Future<void> rejectCampaign() async {
    final url = apiUrl + 'suggestedGroups/rejectCampaign';

    final String idString = suggestedGroup['suggestedCampaigns'][0]['id'];

    final List<JsonIdPayload> payload = [
      JsonIdPayload(idString),
    ];

    print(payload);

    String finalPayload = jsonEncode(payload);
    print(finalPayload);

    try {
      final res = await http.post(
        url,
        headers: <String, String> {
          'Content-Type': 'application/json; charset=UTF-8',
          'auth': _token,
        },
        body: finalPayload
      );

      final extractedData = json.decode(res.body) as Map<String, dynamic>;

      print('Reject data extracted');
      print(extractedData);

    } catch (error) {
      throw(error);
    }
  }
}
