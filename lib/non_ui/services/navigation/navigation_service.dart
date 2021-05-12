import 'package:flutter/material.dart';

class NavigationService {
  // Static instance of NavigationService
  static final NavigationService instance = NavigationService();

  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  Future<T> navigateTo<T extends Object>(Widget page) {
    return navigatorKey.currentState
        .push(MaterialPageRoute(builder: (_) => page));
  }

  void goBack() {
    return navigatorKey.currentState.pop();
  }
}
