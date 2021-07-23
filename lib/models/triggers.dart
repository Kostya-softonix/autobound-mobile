import 'package:flutter/material.dart';

class Trigger {
  final String id;
  final String title;
  final String contacts;
  final int rate;

  int isDone;

  Trigger({
    @required this.id,
    @required this.title,
    @required this.contacts,
    @required this.rate,

    this.isDone
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isDone': isDone,
      'rate': rate,
      'contacts': contacts
    };
  }
}