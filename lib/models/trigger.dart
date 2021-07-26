import 'package:flutter/material.dart';

class Trigger {
  final String id;
  final String name;
  final int contacts;
  final int score;
  final int groups;
  final int campaigns;
  final int companies;

  Trigger({
    @required this.id,
    @required this.name,
    @required this.contacts,
    @required this.score,
    @required this.groups,
    @required this.campaigns,
    @required this.companies,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'score': score,
      'contacts': contacts,
      'groups': groups,
      'campaigns': campaigns,
      'companies': companies,
    };
  }
}