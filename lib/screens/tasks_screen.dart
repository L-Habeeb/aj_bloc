// import 'package:aj_todo/models/task.dart';
import 'package:aj_todo/blocs/bloc_exports.dart';
import 'package:aj_todo/models/task.dart';
import 'package:aj_todo/screens/add_task_screen.dart';
import 'package:aj_todo/screens/my_drawer.dart';
import 'package:aj_todo/widgets/task_list.dart';
import 'package:flutter/material.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  static const id = 'tasks_screen';

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
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
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> tasksList = state.allTasks;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.lightBlue,
            title: const Text('Tasks App'),
            actions: [
              IconButton(
                onPressed: () {
                  _addTask(context);
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          drawer: MyDrawer(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Chip(label: Text('Tasks: ${state.allTasks.length}')),
              ),
              TasksList(tasksList: tasksList),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _addTask(context),
            tooltip: 'Add Task',
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
