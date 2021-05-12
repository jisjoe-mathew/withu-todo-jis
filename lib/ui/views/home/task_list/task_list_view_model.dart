import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:withu_todo/non_ui/constants/strings.dart';
import 'package:withu_todo/non_ui/models/task/task.dart';
import 'package:withu_todo/non_ui/services/navigation/navigation_service.dart';
import 'package:withu_todo/non_ui/services/task/task_service.dart';
import 'package:withu_todo/non_ui/states/busy_state.dart';
import 'package:withu_todo/ui/views/home/task_form/task_form_view.dart';

class TaskListViewModel extends BusyModel {
  final NavigationService _navigationService = NavigationService.instance;

  int _index;

  int get index => _index;

  void updateIndex(int v) {
    this._index = v;
  }

  bool get isAllTask => index == 0;

  String get title =>
      isAllTask ? AppStrings.allTasksTitle : AppStrings.completedTasksTitle;

  String get emptyMessage => isAllTask
      ? AppStrings.addYourFirstTask
      : AppStrings.noCompletedTasksFound;

  void delete(Task task, BuildContext context) {
    final TaskService _taskService =
        Provider.of<TaskService>(context, listen: false);
    _taskService.deleteTask(task);
  }

  void toggleComplete(Task task, BuildContext context) {
    task.toggleComplete();
    final TaskService _taskService =
        Provider.of<TaskService>(context, listen: false);
    _taskService.updateTask(task);
  }

  void navigateToTaskForm({Task task}) {
    _navigationService.navigateTo(TaskFormView(task: task));
  }
}
