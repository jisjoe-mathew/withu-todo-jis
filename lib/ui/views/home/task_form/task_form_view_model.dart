import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:withu_todo/non_ui/constants/strings.dart';
import 'package:withu_todo/non_ui/models/task/task.dart';
import 'package:withu_todo/non_ui/services/navigation/navigation_service.dart';
import 'package:withu_todo/non_ui/services/task/task_service.dart';
import 'package:withu_todo/non_ui/states/busy_state.dart';

class TaskFormViewModel extends BusyModel {
  TaskFormViewModel(this.task) {
    init();
  }

  Task task;

  final NavigationService _navigationService = NavigationService.instance;

  BuildContext get context => _navigationService.navigatorKey.currentContext;

  String get title =>
      (task?.id == null) ? AppStrings.newTaskTitle : AppStrings.editTaskTitle;

  GlobalKey<FormState> formKey;

  TextEditingController titleController;
  TextEditingController descriptionController;

  bool _isEdit = false;

  void init() {
    formKey = GlobalKey<FormState>();
    if (task == null) {
      this.task = Task();
      this.titleController = TextEditingController();
      this.descriptionController = TextEditingController();
    } else {
      _isEdit = true;
      this.titleController = TextEditingController(text: task.title);
      this.descriptionController =
          TextEditingController(text: task.description);
    }
  }

  void toggleComplete() {
    this.task.toggleComplete();
    notifyListeners();
  }

  String get buttonTitle =>
      this.task.isNew ? AppStrings.createBtnTitle : AppStrings.updateBtnTitle;

  void save() async {
    if (formKey.currentState.validate()) {
      setBusy(true);
      final TaskService _taskService =
          Provider.of<TaskService>(context, listen: false);

      bool proceed = _isEdit
          ? await _taskService.updateTask(task)
          : await _taskService.addTask(task);
      if (proceed)
        _navigationService.goBack();
      else
        debugPrint('Something went wrong!!!');
      setBusy(false);
    }
  }
}
