import 'package:flutter/cupertino.dart';
import 'package:withu_todo/non_ui/services/firebase_services/flutterfire_service.dart';
import 'package:withu_todo/non_ui/states/busy_state.dart';

class WithUAppViewModel extends BusyModel {
  WithUAppViewModel() {
    _initState();
  }

  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  bool get initialized => _initialized;

  bool get error => _error;

  set error(bool v) {
    _error = v;
    notifyListeners();
  }

  set initialized(bool v) {
    _initialized = v;
    notifyListeners();
  }

  // Initialize when this model is referenced
  void _initState() {
    initialize();
  }

  final FlutterFireService _flutterFireService = FlutterFireService.instance;

  // Define an async function to initialize FlutterFire
  Future<void> _initializeFlutterFire() async {
    // Wait for Firebase to initialize
    await _flutterFireService.initialization;

    // Pass all uncaught errors to Crashlytics.
    Function originalOnError = FlutterError.onError;
    FlutterError.onError = (FlutterErrorDetails errorDetails) async {
      // Forward to original handler.
      originalOnError(errorDetails);
    };
  }

  // Function to initialize/re-initialize model
  void initialize() async {
    setBusy(true);
    if (_error) error = false;

    try {
      await _initializeFlutterFire();
      initialized = true;
    } catch (e) {
      debugPrint(e);
      error = true;
    }
    setBusy(false);
  }
}
