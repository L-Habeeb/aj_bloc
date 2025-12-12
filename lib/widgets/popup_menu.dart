import 'package:aj_todo/models/task.dart';
import 'package:flutter/material.dart';

class PopupMenu extends StatelessWidget {
  final VoidCallback cancelOrDeleteCallBack;
  final VoidCallback likeOrDislike;
  final VoidCallback editTaskCallback;
  final VoidCallback restoreTaskCallback;
  final Task task;

  const PopupMenu({
    super.key,
    required this.cancelOrDeleteCallBack,
    required this.likeOrDislike,
    required this.editTaskCallback,
    required this.restoreTaskCallback,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: task.isDeleted == false
          ? ((context) => [
              PopupMenuItem(
                onTap: editTaskCallback,
                child: TextButton.icon(
                  onPressed: editTaskCallback,
                  icon: Icon(Icons.edit),
                  label: const Text('edit'),
                ),
              ),
              PopupMenuItem(
                onTap: likeOrDislike,
                child: TextButton.icon(
                  onPressed: () {},
                  icon: task.isFavorite == false
                      ? const Icon(Icons.bookmark_add_outlined)
                      : const Icon(Icons.bookmark_remove),
                  label: task.isFavorite == false
                      ? const Text('Add to Bookmark')
                      : const Text('Remove from Bookmark'),
                ),
              ),
              PopupMenuItem(
                onTap: cancelOrDeleteCallBack,
                child: TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.delete),
                  label: const Text('Delete'),
                ),
              ),
            ])
          : ((context) => [
              PopupMenuItem(
                onTap: restoreTaskCallback,
                child: TextButton.icon(
                  onPressed: restoreTaskCallback,
                  icon: Icon(Icons.restore_from_trash),
                  label: const Text('restore'),
                ),
              ),
              PopupMenuItem(
                onTap: cancelOrDeleteCallBack,
                child: TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.delete_forever),
                  label: const Text('Delete Permanently'),
                ),
              ),
            ]),
    );
  }
}
