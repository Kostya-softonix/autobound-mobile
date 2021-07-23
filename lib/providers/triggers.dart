import 'package:flutter/widgets.dart';

import '../models/triggers.dart';


class Triggers with ChangeNotifier {
  List<Trigger> _triggers = [
    Trigger(
      id: '1',
      title: 'Trigger for Colorado Rockets',
      contacts: '6 contacts / 1 companies / 1 groups',
      rate: 92,
      isDone: 1
    ),
    Trigger(
      id: '2',
      title: 'AC trigger 90',
      contacts: '6 contacts / 1 companies / 1 groups',
      rate: 94,
      isDone: 2
    ),
    Trigger(
      id: '3',
      title: 'Trigger for Colorado Rockets',
      contacts: '6 contacts / 1 companies / 1 groups',
      rate: 92,
      isDone: 1
    ),
    Trigger(
      id: '4',
      title: 'AC trigger 90',
      contacts: '6 contacts / 1 companies / 1 groups',
      rate: 94,
      isDone: 2
    ),
    Trigger(
      id: '5',
      title: 'Trigger for Colorado Rockets',
      contacts: '6 contacts / 1 companies / 1 groups',
      rate: 92,
      isDone: 1
    ),
    Trigger(
      id: '6',
      title: 'AC trigger 90',
      contacts: '6 contacts / 1 companies / 1 groups',
      rate: 94,
      isDone: 2
    ),
    Trigger(
      id: '7',
      title: 'Trigger for Colorado Rockets',
      contacts: '6 contacts / 1 companies / 1 groups',
      rate: 92,
      isDone: 1
    ),
    Trigger(
      id: '8',
      title: 'AC trigger 90',
      contacts: '6 contacts / 1 companies / 1 groups',
      rate: 94,
      isDone: 2
    ),
     Trigger(
      id: '9',
      title: 'Trigger for Colorado Rockets',
      contacts: '6 contacts / 1 companies / 1 groups',
      rate: 92,
      isDone: 1
    ),
    Trigger(
      id: '10',
      title: 'AC trigger 90',
      contacts: '6 contacts / 1 companies / 1 groups',
      rate: 94,
      isDone: 2
    ),
  ];

  List<Trigger> get triggers {
    return [..._triggers];
  }
}