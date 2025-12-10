import 'package:aj_todo/screens/add_task_screen.dart';
import 'package:flutter/material.dart';

class TabsScreens extends StatelessWidget {
  const TabsScreens({super.key});

  static const id = 'tabs_screen';
  void _addTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: const AddTaskScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
