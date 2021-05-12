import 'package:flutter/cupertino.dart';
import 'package:withu_todo/non_ui/models/task/task.dart';
import 'package:withu_todo/non_ui/services/firebase/firestore_service.dart';
import 'package:withu_todo/non_ui/states/busy_state.dart';

class TaskService extends BusyModel {
  TaskService() {
    listenToTask();
  }
  final FireStoreService _fireStoreService = FireStoreService.instance;

  List<Task> _tasks = <Task>[];

  List<Task> get tasks => _tasks;

  set tasks(List<Task> v) {
    _tasks = v;
    notifyListeners();
  }

  void listenToTask() {
    _fireStoreService.tasksRef.snapshots().listen((event) {
      tasks =
          event.docs.map((e) => Task.fromJson(e.data())..id = e.id).toList();
    });
  }

  Future<bool> addTask(Task task) async {
    bool success = false;
    try {
      await _fireStoreService.tasksRef.add(task.toJson());
      success = true;
    } catch (e) {
      debugPrint(e);
    }
    return success;
  }

  Future<bool> updateTask(Task task) async {
    bool success = false;
    try {
      await _fireStoreService.tasksRef.doc(task.id).update(task.toJson());
      success = true;
    } catch (e) {
      debugPrint(e);
    }
    return success;
  }

  Future<bool> deleteTask(Task task) async {
    bool success = false;
    try {
      await _fireStoreService.tasksRef.doc(task.id).delete();
      success = true;
    } catch (e) {
      debugPrint(e);
    }
    return success;
  }
}
