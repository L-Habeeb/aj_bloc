import 'package:aj_todo/blocs/bloc_exports.dart';
import 'package:aj_todo/models/task.dart';
import 'package:aj_todo/services/guid_gen.dart';
import 'package:flutter/material.dart';


class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
  final TextEditingController titleController = TextEditingController();
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text('Add Task', style: TextStyle(fontSize: 24)),
          const SizedBox(height: 10),
          TextField(
            autofocus: true,
            controller: titleController,
            decoration: const InputDecoration(
              label: Text('Title'),
              border: OutlineInputBorder(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  var task = Task(title: titleController.text, id: GUIDGen.generate());
                  context.read<TasksBloc>().add(AddTaskEvent(task: task));
                  Navigator.pop(context);
                },
                child: const Text('Add'),
              ),
            ],
          ),
          
        ],
      ),
    );
  }
}
