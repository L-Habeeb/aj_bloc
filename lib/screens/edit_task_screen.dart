import 'package:aj_todo/blocs/bloc_exports.dart';
import 'package:aj_todo/models/task.dart';
import 'package:flutter/material.dart';

class EditTasksScreen extends StatelessWidget {
  final Task oldTask;
  const EditTasksScreen({super.key, required this.oldTask});

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController(
      text: oldTask.title,
    );
    final TextEditingController descriptionController = TextEditingController(
      text: oldTask.description,
    );
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text('Edit Task', style: TextStyle(fontSize: 24)),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
            child: TextField(
              autofocus: true,
              controller: titleController,
              decoration: const InputDecoration(
                label: Text('Title'),
                border: OutlineInputBorder(),
              ),
            ),
          ),

          TextField(
            autofocus: true,
            controller: descriptionController,
            minLines: 3,
            maxLines: 5,
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
                  var editedTask = Task(
                    date: DateTime.now().toString(),
                    title: titleController.text,
                    description: descriptionController.text,
                    isDone: false,
                    isFavorite: oldTask.isFavorite,
                    id: oldTask.id,
                  );
                  context.read<TasksBloc>().add(
                    EditTaskEvent(oldTask: oldTask, newTask: editedTask),
                  );
                  Navigator.pop(context);
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
