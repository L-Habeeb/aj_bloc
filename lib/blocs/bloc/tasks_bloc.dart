import 'package:aj_todo/models/task.dart';
// import 'package:aj_todo/blocs/bloc/tasks_event.dart';
// import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../bloc_exports.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends HydratedBloc<TasksEvent, TasksState> {
  TasksBloc() : super(const TasksState()) {
    on<AddTaskEvent>(_onAddTaskEvent);
    on<UpdateTaskEvent>(_onUpdateTaskEvent);
    on<DeleteTaskEvent>(_onDeleteTaskEvent);
  }

  void _onAddTaskEvent(AddTaskEvent event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(allTasks: List.from(state.allTasks)..add(event.task)));
  }

  void _onUpdateTaskEvent(UpdateTaskEvent event, Emitter<TasksState> emit) {
    final task = event.task;
    final int index = state.allTasks.indexOf(task);

    List<Task> allTask = List.from(state.allTasks)..remove(task);
    task.isDone == false
        ? allTask.insert(index, task.copyWIth(isDone: true))
        : allTask.insert(index, task.copyWIth(isDone: false));
    emit(TasksState(allTasks: allTask));
  }

  void _onDeleteTaskEvent(DeleteTaskEvent event, Emitter<TasksState> emit) {
    final task = event.task;
    List<Task> allTask = List.from(state.allTasks)..remove(task);
    emit(TasksState(allTasks: allTask));
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
