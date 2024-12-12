import 'package:flutter/material.dart';

class MyNavigatorObserver extends NavigatorObserver {
  final Function onPopPage;

  MyNavigatorObserver(this.onPopPage);

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    onPopPage();
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
  }
}
