import 'package:aj_todo/blocs/bloc_exports.dart';
import 'package:aj_todo/models/task.dart';
import 'package:aj_todo/screens/edit_task_screen.dart';
import 'package:aj_todo/widgets/popup_menu.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({super.key, required this.task});

  final Task task;

  void _removeOrDeleteTask(BuildContext ctx, Task task) {
    task.isDeleted!
        ? ctx.read<TasksBloc>().add(DeleteTaskEvent(task: task))
        : ctx.read<TasksBloc>().add(RemoveTaskEvent(task: task));
  }

  void _editTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: EditTasksScreen(oldTask: task),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                task.isFavorite == false
                    ? Icon(Icons.star_outline)
                    : Icon(Icons.star),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          decoration: task.isDone!
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      Text(
                        DateFormat().add_yMMMd().add_Hms().format(
                          DateTime.parse(task.date!),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              PopupMenu(
                task: task,
                cancelOrDeleteCallBack: () =>
                    _removeOrDeleteTask(context, task),
                likeOrDislike: () => context.read<TasksBloc>().add(
                  MarkFavOrUnFavTaskEvent(task: task),
                ),
                editTaskCallback: () {
                  _editTask(context);
                },
                restoreTaskCallback: () =>
                    context.read<TasksBloc>().add(RestoreTaskEvent(task: task)),
              ),
              Checkbox(
                value: task.isDone,
                onChanged: task.isDeleted == false
                    ? (value) => context.read<TasksBloc>().add(
                        UpdateTaskEvent(task: task),
                      )
                    : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}




// ListTile(
      // title: Text(
      //   task.title,
      //   overflow: TextOverflow.ellipsis,
      //   style: TextStyle(
      //     decoration: task.isDone! ? TextDecoration.lineThrough : null,
      //   ),
      // ),
      // trailing: Checkbox(
      //   value: task.isDone,
      //   onChanged: 
      //     task.isDeleted == false
      //         ? (value) => context.read<TasksBloc>().add(UpdateTaskEvent(task: task))
      //         : null,
      // ),
//       onLongPress: () => _removeOrDeleteTask(context, task),
//     );
