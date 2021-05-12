import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:withu_todo/non_ui/constants/strings.dart';
import 'package:withu_todo/non_ui/models/task/task.dart';
import 'package:withu_todo/non_ui/services/dialog/dialog_service.dart';
import 'package:withu_todo/non_ui/services/navigation/navigation_service.dart';
import 'package:withu_todo/non_ui/services/task/task_service.dart';
import 'package:withu_todo/non_ui/states/busy_state.dart';
import 'package:withu_todo/ui/views/home/task_form/task_form_view.dart';

class TaskListViewModel extends BusyModel {
  final NavigationService _navigationService = NavigationService.instance;
  final DialogService _dialogService = DialogService.instance;

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

  void delete(Task task, BuildContext context) async {
    var dialogResult = await _dialogService.showDialog(
      title: AppStrings.warningTitle,
      description: '${task.title} will be deleted.',
      buttonTitle: 'CONFIRM',
    );
    if (dialogResult.confirmed == true) {
      final TaskService _taskService =
          Provider.of<TaskService>(context, listen: false);
      _taskService.deleteTask(task);
    } else {
      debugPrint('User cancelled the dialog');
    }
  }

  void toggleComplete(Task task, BuildContext context) {
    task.toggleComplete();
    final TaskService _taskService =
        Provider.of<TaskService>(context, listen: false);
    _taskService.updateTask(task);
    EasyLoading.showToast(
        task.isCompleted
            ? AppStrings.toastComplete
            : AppStrings.toastIncomplete,
        toastPosition: EasyLoadingToastPosition.bottom);
  }

  void navigateToTaskForm({Task task}) {
    _navigationService.navigateTo(TaskFormView(task: task));
  }
}
