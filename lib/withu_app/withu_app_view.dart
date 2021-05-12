import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:withu_todo/non_ui/constants/strings.dart';
import 'package:withu_todo/non_ui/services/navigation/navigation_service.dart';
import 'package:withu_todo/non_ui/services/task/task_service.dart';
import 'package:withu_todo/ui/pages/home.dart';
import 'package:withu_todo/ui/widgets/message/error_widget.dart';
import 'package:withu_todo/withu_app/withu_app_view_model.dart';

class WithUAppView extends StatelessWidget {
  const WithUAppView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<WithUAppViewModel>(
          create: (context) => WithUAppViewModel(),
        ),
        ChangeNotifierProvider<TaskService>(
          create: (context) => TaskService(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppStrings.appTitle,
        navigatorKey: NavigationService.instance.navigatorKey,
        home: Consumer<WithUAppViewModel>(
          builder: (context, model, child) {
            return model.initialized
                //Todo
                ? HomeTabsPage()
                : Scaffold(
                    body: model.isBusy
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : model.error
                            ? ErrorMessage(
                                message: AppStrings.problemInitializingApp,
                                buttonTitle: AppStrings.retryBtnTitle,
                                onTap: model.initialize,
                              )
                            : Container(),
                  );
          },
        ),
      ),
    );
  }
}
