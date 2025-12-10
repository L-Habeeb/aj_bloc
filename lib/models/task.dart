import 'package:equatable/equatable.dart';

class Task extends Equatable{
  final String title;
  final bool? isDone;
  final String id;
  final bool? isDeleted;

  const Task({
    required this.title,
    this.isDone = false,
    required this.id,
    this.isDeleted = false,
  });

  Task copyWIth({
    String? title,
    String? id,
    bool? isDone,
    bool? isDeleted,
  }) {
    return Task(
      title: title ?? this.title,
      id: id ?? this.id,
      isDone: isDone ?? this.isDone,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'isDone': isDone,
      'id': id,
      'isDeleted': isDeleted,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'] ?? '',
      id: map['id'] ?? '',
      isDone: map['isDone'],
      isDeleted: map['isDeleted'],
    );
  }

  @override
  List<Object?> get props => [
    title,
    id,
    isDone,
    isDeleted,
  ];

}
