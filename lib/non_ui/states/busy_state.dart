import 'package:flutter/foundation.dart';

/// Class to handle loading state
abstract class BusyState {
  void setBusy(bool v);
}

/// This[BusyModel] model handles loading state of KModel
class BusyModel extends ChangeNotifier with BusyState {
  bool _busy = false;

  bool get isBusy => _busy;

  @override
  void setBusy(v) {
    _busy = v;
    notifyListeners();
  }
}
