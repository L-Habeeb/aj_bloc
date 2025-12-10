import 'package:aj_todo/screens/recycle_bin.dart';
import 'package:aj_todo/screens/tasks_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RecycleBin.id:
        return MaterialPageRoute(builder: (_) => const RecycleBin());

      case TasksScreen.id:
        return MaterialPageRoute(builder: (_) => const TasksScreen());

      default:
        return null;
    }
  }
}
