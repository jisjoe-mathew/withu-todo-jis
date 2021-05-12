import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:withu_todo/non_ui/models/task/task.dart';
import 'package:withu_todo/ui/widgets/card/elevated_card.dart';

import 'task_list_view_model.dart';

class TaskListView extends StatelessWidget {
  TaskListView({Key key, @required this.index, @required this.tasks})
      : super(key: key);
  final int index;
  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TaskListViewModel>(
      create: (context) => TaskListViewModel(),
      child: Consumer<TaskListViewModel>(
        builder: (context, model, child) {
          model.updateIndex(this.index);
          return Scaffold(
            appBar: AppBar(
              title: Text(model.title),
              actions: [
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: model.navigateToTaskForm,
                ),
              ],
            ),
            body: tasks.isEmpty
                ? Center(
                    child: Text(model.emptyMessage),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return _TaskCard(
                        task: tasks[index],
                        delete: () => model.delete(tasks[index], context),
                        toggleComplete: () =>
                            model.toggleComplete(tasks[index], context),
                        view: model.navigateToTaskForm,
                      );
                    },
                  ),
          );
        },
      ),
    );
  }
}

class _TaskCard extends StatelessWidget {
  const _TaskCard(
      {Key key,
      @required this.task,
      @required this.delete,
      @required this.toggleComplete,
      @required this.view})
      : super(key: key);

  final Task task;
  final VoidCallback delete;
  final VoidCallback toggleComplete;
  final Function({Task task}) view;

  @override
  Widget build(BuildContext context) {
    return ElevatedCard(
      child: ListTile(
        leading: IconButton(
          icon: Icon(
            task.isCompleted ? Icons.check_box : Icons.check_box_outline_blank,
          ),
          onPressed: () => toggleComplete?.call(),
        ),
        title: Text(task?.title ?? ''),
        subtitle: Text(task?.description ?? ''),
        trailing: IconButton(
          icon: Icon(
            Icons.delete,
          ),
          onPressed: () => delete?.call(),
        ),
        onTap: () => view?.call(task: task),
      ),
    );
  }
}
