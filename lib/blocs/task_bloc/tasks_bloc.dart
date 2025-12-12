import 'package:aj_todo/models/task.dart';
import 'package:equatable/equatable.dart';

import '../bloc_exports.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends HydratedBloc<TasksEvent, TasksState> {
  TasksBloc() : super(const TasksState()) {
    on<AddTaskEvent>(_onAddTaskEvent);
    on<UpdateTaskEvent>(_onUpdateTaskEvent);
    on<DeleteTaskEvent>(_onDeleteTaskEvent);
    on<RemoveTaskEvent>(_onRemoveTaskEvent);
    on<MarkFavOrUnFavTaskEvent>(_onMarkFavOrUnFavTaskEvent);
    on<EditTaskEvent>(_onEditTaskEvent);
    on<RestoreTaskEvent>(_onRestoreTaskEvent);
    on<DeleteAllTaskEvent>(_onDeleteAllTaskEvent);
  }

  void _onAddTaskEvent(AddTaskEvent event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(
      TasksState(
        pendingTask: List.from(state.pendingTask)..add(event.task),
        removedTasks: state.removedTasks,
        completedTask: state.completedTask,
        favoriteTask: state.favoriteTask,
      ),
    );
  }

  void _onRemoveTaskEvent(RemoveTaskEvent event, Emitter<TasksState> emit) {
    final task = event.task;
    // ignore: unused_local_variable
    List<Task> pendingTasks = List.from(state.pendingTask)..remove(task);
    List<Task> removedTask = List.from(state.removedTasks)
      ..add(task.copyWIth(isDeleted: true));

    List<Task> completedTask = List.from(state.completedTask)..remove(task);
    List<Task> favoriteTask = List.from(state.favoriteTask)..remove(task);

    emit(
      TasksState(
        pendingTask: pendingTasks,
        removedTasks: removedTask,
        completedTask: completedTask,
        favoriteTask: favoriteTask,
      ),
    );
  }

  void _onMarkFavOrUnFavTaskEvent(
    MarkFavOrUnFavTaskEvent event,
    Emitter<TasksState> emit,
  ) {
    List<Task> pendingTasks = state.pendingTask;
    List<Task> completedTasks = state.completedTask;
    List<Task> favoriteTasks = state.favoriteTask;

    if (event.task.isDone == false) {
      if (event.task.isFavorite == false) {
        var taskIndex = pendingTasks.indexOf(event.task);
        pendingTasks = List.from(pendingTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWIth(isFavorite: true));
        favoriteTasks.insert(0, event.task.copyWIth(isFavorite: true));
      } else {
        var taskIndex = pendingTasks.indexOf(event.task);
        pendingTasks = List.from(pendingTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWIth(isFavorite: false));
        favoriteTasks.remove(event.task);
      }
    } else {
      if (event.task.isFavorite == false) {
        var taskIndex = completedTasks.indexOf(event.task);
        completedTasks = List.from(completedTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWIth(isFavorite: true));
        favoriteTasks.insert(0, event.task.copyWIth(isFavorite: true));
      } else {
        var taskIndex = completedTasks.indexOf(event.task);
        completedTasks = List.from(completedTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWIth(isFavorite: false));
        favoriteTasks.remove(event.task);
      }
    }
    emit(
      TasksState(
        completedTask: completedTasks,
        favoriteTask: favoriteTasks,
        pendingTask: pendingTasks,
        removedTasks: state.removedTasks,
      ),
    );
  }

  void _onUpdateTaskEvent(UpdateTaskEvent event, Emitter<TasksState> emit) {
    final task = event.task;

    // Toggle task
    final updatedTask = task.copyWIth(isDone: !task.isDone!);

    // Copy lists
    List<Task> pendingTask = List.from(state.pendingTask);
    List<Task> completedTask = List.from(state.completedTask);

    // Remove the task from both lists (just to be safe)
    pendingTask.remove(task);
    completedTask.remove(task);

    // Now put the updated version in the correct list
    if (updatedTask.isDone!) {
      completedTask.insert(0, updatedTask);
    } else {
      pendingTask.insert(0, updatedTask);
    }

    emit(
      TasksState(
        pendingTask: pendingTask,
        removedTasks: state.removedTasks,
        completedTask: completedTask,
        favoriteTask: state.favoriteTask,
      ),
    );
  }

  void _onRestoreTaskEvent(RestoreTaskEvent event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(
      TasksState(
        removedTasks: List.from(state.removedTasks)..remove(event.task),
        pendingTask: List.from(state.pendingTask)
          ..insert(
            0,
            event.task.copyWIth(
              isDeleted: false,
              isDone: false,
              isFavorite: false,
            ),
          ),
        completedTask: state.completedTask,
        favoriteTask: state.favoriteTask,
      ),
    );
  }

  void _onEditTaskEvent(EditTaskEvent event, Emitter<TasksState> emit) {
    final state = this.state;
    List<Task> favouriteTasks = state.favoriteTask;
    if (event.oldTask.isFavorite == true) {
      favouriteTasks
        ..remove(event.oldTask)
        ..insert(0, event.newTask);
    }
    emit(
      TasksState(
        pendingTask: List.from(state.pendingTask)
          ..remove(event.oldTask)
          ..insert(0, event.newTask),
        completedTask: state.completedTask..remove(event.oldTask),
        favoriteTask: favouriteTasks,
        removedTasks: state.removedTasks,
      ), // TasksState
    );
  }

  void _onDeleteTaskEvent(DeleteTaskEvent event, Emitter<TasksState> emit) {
    emit(
      TasksState(
        pendingTask: state.pendingTask,
        removedTasks: List.from(state.removedTasks)..remove(event.task),
      ),
    );
  }

  void _onDeleteAllTaskEvent(DeleteAllTaskEvent event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(
      TasksState(
        removedTasks: List.from(state.removedTasks)..clear(),
        pendingTask: state.pendingTask,
        completedTask: state.completedTask,
        favoriteTask: state.favoriteTask,
      ), // TasksState
    );
  }


  @override
  TasksState? fromJson(Map<String, dynamic> json) {
    return TasksState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TasksState state) {
    return state.toMap();
  }
}

  // void _onUpdateTaskEvent(UpdateTaskEvent event, Emitter<TasksState> emit) {
  //   final task = event.task;
  //   List<Task> pendingTask = state.pendingTask;
  //   List<Task> completedTask = state.completedTask;

  //   task.isDone == false
  //       ? {
  //           pendingTask = List.from(pendingTask)..remove(task),
  //           completedTask = List.from(completedTask)
  //             ..insert(0, task.copyWIth(isDone: true)),
  //         }
  //       : {
  //           completedTask = List.from(completedTask)..remove(task),
  //           pendingTask = List.from(pendingTask)
  //             ..insert(0, task.copyWIth(isDone: false)),
  //         };

  //   emit(
  //     TasksState(
  //       pendingTask: pendingTask,
  //       removedTasks: state.removedTasks,
  //       completedTask: completedTask,
  //       favoriteTask: state.favoriteTask,
  //     ),
  //   );
  // }