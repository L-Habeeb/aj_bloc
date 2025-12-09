import 'package:aj_todo/models/task.dart';
// import 'package:aj_todo/blocs/bloc/tasks_event.dart';
// import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../bloc_exports.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

// class TasksBloc extends Bloc<TasksEvent, TasksState> {
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
  String get storagePrefix => 'TasksBloc';

  @override
  TasksState? fromJson(Map<String, dynamic> json) {
    try {
      return TasksState.fromMap(json);
    } catch (e) {
      // Return null if deserialization fails - bloc will use initial state
      print('Error deserializing TasksState: $e');
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(TasksState state) {
    try {
      return state.toMap();
    } catch (e) {
      // Return null if serialization fails - state won't be persisted
      print('Error serializing TasksState: $e');
      return null;
    }
  }



  // @override
  // TasksState? fromJson(Map<String, dynamic> json) {
  //   return TasksState.fromMap(json);
  // }


  // @override
  // Map<String, dynamic>? toJson(TasksState state) {
  //   return state.toMap();
  // }
}
