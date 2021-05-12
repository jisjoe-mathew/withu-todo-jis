import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  // Static instance of FireStoreService
  static final FireStoreService instance = FireStoreService();

  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  CollectionReference get tasksRef =>
      FirebaseFirestore.instance.collection('withu-jis');
}
