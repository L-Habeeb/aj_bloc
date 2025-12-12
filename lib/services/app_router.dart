import 'package:aj_todo/screens/recycle_bin.dart';
import 'package:aj_todo/screens/tabs_screens.dart';
import 'package:aj_todo/screens/pending_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RecycleBin.id:
        return MaterialPageRoute(builder: (_) => const RecycleBin());

      case TabsScreens.id:
        return MaterialPageRoute(builder: (_) => const TabsScreens());

      default:
        return null;
    }
  }
}
