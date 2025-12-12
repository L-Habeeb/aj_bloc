import 'package:equatable/equatable.dart';

class Task extends Equatable{
  final String title;
  final String description;
  final bool? isDone;
  final String id;
  final bool? isDeleted;
  final String? date;
  final bool? isFavorite;

  const Task({
    required this.date,
    required this.title,
    required this.description,
    required this.id,
    this.isDone = false,
    this.isFavorite = false,
    this.isDeleted = false,
  });

  Task copyWIth({
    String? title,
    String? description,
    String? id,
    String? date,
    bool? isFavorite,
    bool? isDone,
    bool? isDeleted,
  }) {
    return Task(
      title: title ?? this.title,
      description: description ?? this.description,
      id: id ?? this.id,
      date: date ?? this.date,
      isFavorite: isFavorite ?? this.isFavorite,
      isDone: isDone ?? this.isDone,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'isDone': isDone,
      'id': id,
      'isFavorite': isFavorite,
      'date': date,
      'isDeleted': isDeleted,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'] ?? '',
      isFavorite: map['isFavorite'] ?? '',
      date: map['date'] ?? '',
      description: map['description'] ?? '',
      id: map['id'] ?? '',
      isDone: map['isDone'],
      isDeleted: map['isDeleted'],
    );
  }

  @override
  List<Object?> get props => [
    title,
    description,
    date,
    isFavorite,
    id,
    isDone,
    isDeleted,
  ];

}
