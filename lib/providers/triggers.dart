import 'package:flutter/widgets.dart';

import '../models/trigger.dart';

class Triggers with ChangeNotifier {
  List<Trigger> _triggers = [];

  List<Trigger> get triggers {
    return [..._triggers];
  }
}