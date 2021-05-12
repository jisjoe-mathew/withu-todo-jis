import 'package:firebase_core/firebase_core.dart';

class FlutterFireService {
  // Static instance of FlutterFireService
  static final FlutterFireService instance = FlutterFireService();

  // Asynchronous function to initialize FlutterFire
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  Future<FirebaseApp> get initialization => _initialization;
}
