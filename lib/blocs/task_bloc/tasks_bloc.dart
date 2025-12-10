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
  }

  void _onAddTaskEvent(AddTaskEvent event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
      allTasks: List.from(state.allTasks)..add(event.task),
      removedTasks: state.removedTasks,
      ),
    );
  }

  void _onRemoveTaskEvent(RemoveTaskEvent event, Emitter<TasksState> emit) {
    final task = event.task;
    // ignore: unused_local_variable
    List<Task> allTask = List.from(state.allTasks)..remove(task);
    List<Task> removedTask = List.from(state.removedTasks)..add(task.copyWIth(isDeleted: true));
    emit(TasksState(
      allTasks: allTask,
      removedTasks: removedTask
      ),
    );
  }

  void _onUpdateTaskEvent(UpdateTaskEvent event, Emitter<TasksState> emit) {
    final task = event.task;
    final int index = state.allTasks.indexOf(task);

    List<Task> allTask = List.from(state.allTasks)..remove(task);
    task.isDone == false
        ? allTask.insert(index, task.copyWIth(isDone: true))
        : allTask.insert(index, task.copyWIth(isDone: false));
    emit(TasksState(
      allTasks: allTask,
      removedTasks: state.removedTasks,
      ),
    );
  }

  void _onDeleteTaskEvent(DeleteTaskEvent event, Emitter<TasksState> emit) {
    emit(TasksState(
      allTasks: state.allTasks,
      removedTasks: List.from(state.removedTasks)..remove(event.task)
      ),
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
