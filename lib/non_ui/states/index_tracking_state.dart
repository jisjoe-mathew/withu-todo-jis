import 'package:withu_todo/non_ui/states/busy_state.dart';

/// Class to handle tab index state
abstract class IndexTrackingState {
  void setIndex(int v);
}

/// This[IndexTrackingModel] model handles index & loading state of KModel
class IndexTrackingModel extends BusyModel with IndexTrackingState {
  int _index = 0;

  int get currentIndex => _index;

  @override
  void setIndex(int index) {
    _index = index;
    notifyListeners();
  }
}
