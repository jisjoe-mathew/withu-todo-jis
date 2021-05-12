import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:withu_todo/non_ui/constants/strings.dart';
import 'package:withu_todo/non_ui/models/task/task.dart';
import 'package:withu_todo/ui/views/home/task_form/task_form_view_model.dart';

class TaskFormView extends StatelessWidget {
  const TaskFormView({Key key, this.task}) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TaskFormViewModel>(
      create: (context) => TaskFormViewModel(this.task),
      child: Consumer<TaskFormViewModel>(
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(model.title),
            ),
            body: _Body(),
          );
        },
      ),
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskFormViewModel>(
      builder: (context, model, child) {
        return SafeArea(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: model.formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: model.titleController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: AppStrings.titleLabel,
                    ),
                    validator: (txt) {
                      if (txt.isEmpty) return AppStrings.titleValidation;
                      return null;
                    },
                    onChanged: (txt) => model.task.title = txt,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: model.descriptionController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: AppStrings.descriptionLabel,
                    ),
                    minLines: 5,
                    maxLines: 10,
                    validator: (txt) {
                      if (txt.isEmpty) return AppStrings.descriptionValidation;
                      return null;
                    },
                    onChanged: (txt) => model.task.description = txt,
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppStrings.completeLabel),
                      CupertinoSwitch(
                        value: model.task.isCompleted,
                        onChanged: (_) {
                          model.toggleComplete();
                        },
                      ),
                    ],
                  ),
                  Spacer(),
                  model.isBusy
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: model.save,
                          child: Container(
                            width: double.infinity,
                            child: Center(child: Text(model.buttonTitle)),
                          ),
                        )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
