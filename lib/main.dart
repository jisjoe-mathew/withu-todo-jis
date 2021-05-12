import 'dart:async';

import 'package:flutter/material.dart';
import 'package:withu_todo/withu_app/withu_app_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runZonedGuarded(() {
    runApp(WithUAppView());
  }, (error, stackTrace) {
    debugPrint('runZonedGuarded: Caught error in my root zone.');
  });
}
