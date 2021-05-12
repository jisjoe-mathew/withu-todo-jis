import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:withu_todo/non_ui/constants/strings.dart';
import 'package:withu_todo/non_ui/models/task/task.dart';
import 'package:withu_todo/non_ui/services/task/task_service.dart';
import 'package:withu_todo/ui/views/home/task_list/task_list_view.dart';

import 'home_page_view_model.dart';

class HomePageView extends StatelessWidget {
  HomePageView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomePageViewModel>(
      create: (context) => HomePageViewModel(),
      child: Consumer<HomePageViewModel>(
        builder: (context, model, child) {
          return Scaffold(
            body: children(Provider.of<TaskService>(context).tasks,
                model.currentIndex)[model.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              onTap: model.setIndex,
              currentIndex: model.currentIndex,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.list),
                  label: AppStrings.allTasksTitle,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.check),
                  label: AppStrings.completedTasksTitle,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<Widget> children(List<Task> tasks, int index) => [
        TaskListView(
          index: index,
          tasks: tasks,
        ),
        TaskListView(
          index: index,
          tasks: tasks.where((t) => t.isCompleted).toList(),
        )
      ];
}
