part of 'tasks_bloc.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object> get props => [];
}


class AddTaskEvent extends TasksEvent {
  final Task task;
  
  const AddTaskEvent({
    required this.task,
  });

  @override
  List<Object> get props => [task];
}

class MarkFavOrUnFavTaskEvent extends TasksEvent {
  final Task task;

  const MarkFavOrUnFavTaskEvent({
    required this.task,
  });

  @override
  List<Object> get props => [task];
}


class RestoreTaskEvent extends TasksEvent {
  final Task task;

  const RestoreTaskEvent({
    required this.task,
  });

  @override
  List<Object> get props => [task];
}


class EditTaskEvent extends TasksEvent {
  final Task oldTask;
  final Task newTask;

  const EditTaskEvent({
    required this.oldTask,
    required this.newTask,
  });

  @override
  List<Object> get props => [oldTask, newTask];
}


class RemoveTaskEvent extends TasksEvent {
  final Task task;
  
  const RemoveTaskEvent({
    required this.task,
  });

  @override
  List<Object> get props => [task];
}


class UpdateTaskEvent extends TasksEvent {
  final Task task;
  
  const UpdateTaskEvent({
    required this.task,
  });

  @override
  List<Object> get props => [task];
}


class DeleteTaskEvent extends TasksEvent {
  final Task task;
  
  const DeleteTaskEvent({
    required this.task,
  });

  @override
  List<Object> get props => [task];
}


class DeleteAllTaskEvent extends TasksEvent {}

