import 'package:flutter/foundation.dart';

class PlanRefreshBus extends ChangeNotifier {
  PlanRefreshBus._();

  static final PlanRefreshBus instance = PlanRefreshBus._();

  int _revision = 0;

  int get revision => _revision;

  void markChanged() {
    _revision += 1;
    notifyListeners();
  }
}
