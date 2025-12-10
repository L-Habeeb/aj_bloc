import 'package:aj_todo/blocs/bloc_exports.dart';
import 'package:aj_todo/models/task.dart';
import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({super.key, required this.task});

  final Task task;

  void _removeOrDeleteTask(BuildContext ctx, Task task) {
    task.isDeleted!
        ? ctx.read<TasksBloc>().add(DeleteTaskEvent(task: task))
        : ctx.read<TasksBloc>().add(RemoveTaskEvent(task: task));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        task.title,
        style: TextStyle(
          decoration: task.isDone! ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: Checkbox(
        value: task.isDone,
        onChanged: 
          task.isDeleted == false
              ? (value) => context.read<TasksBloc>().add(UpdateTaskEvent(task: task))
              : null,
      ),
      onLongPress: () => _removeOrDeleteTask(context, task),
    );
  }
}


