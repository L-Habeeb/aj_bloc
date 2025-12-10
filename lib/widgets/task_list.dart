import 'package:aj_todo/models/task.dart';
import 'package:aj_todo/widgets/task_tile.dart';
import 'package:flutter/material.dart';

class TasksList extends StatelessWidget {
  const TasksList({super.key, required this.tasksList});

  final List<Task> tasksList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: tasksList.length,
        itemBuilder: (context, index) {
          var task = tasksList[index];
          return TaskTile(task: task);
        },
      ),
    );
  }
}
