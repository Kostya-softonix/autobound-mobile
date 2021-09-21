import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import '../models/trigger.dart';


class Triggers with ChangeNotifier {
  static const apiUrl = 'https://dev.autobound.ai/api/';

  List<Trigger> _triggers = [];

  List<Trigger> get triggers {
    return [..._triggers];
  }

  Future<void> fetchTriggers(String token) async {
    print('Triggered pull');
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

      print(extractedData);

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

      notifyListeners();

    } catch (error) {
      throw(error);
    }
  }
}