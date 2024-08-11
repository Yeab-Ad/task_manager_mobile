import 'package:equatable/equatable.dart';

abstract class TaskEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class TaskCreate extends TaskEvent {
  final String title;
  final String description;
  final DateTime dueDate;
  final String priority;

  TaskCreate(
      {required this.title,
      required this.description,
      required this.dueDate,
      required this.priority,
      required bool completed});

  @override
  List<Object?> get props => [title, description, dueDate, priority];
}

class TaskUpdate extends TaskEvent {
  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  final String priority;

  TaskUpdate(
      {required this.id,
      required this.title,
      required this.description,
      required this.dueDate,
      required this.priority,
      required bool completed});

  @override
  List<Object?> get props => [id, title, description, dueDate, priority];
}

class TaskDelete extends TaskEvent {
  final String id;

  TaskDelete({required this.id});

  @override
  List<Object?> get props => [id];
}

class TaskFetchAll extends TaskEvent {}

// import 'package:equatable/equatable.dart';

// abstract class TaskEvent extends Equatable {
//   const TaskEvent();

//   @override
//   List<Object?> get props => [];
// }

// class LoadTasks extends TaskEvent {}

// class CreateTask extends TaskEvent {
//   final String title;
//   final String description;
//   final DateTime dueDate;
//   final int priority;
//   final bool completed;

//   const CreateTask({
//     required this.title,
//     required this.description,
//     required this.dueDate,
//     required this.priority,
//     required this.completed,
//   });

//   @override
//   List<Object?> get props => [title, description, dueDate, priority, completed];
// }

// class UpdateTask extends TaskEvent {
//   final String id;
//   final String title;
//   final String description;
//   final DateTime dueDate;
//   final int priority;
//   final bool completed;

//   const UpdateTask({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.dueDate,
//     required this.priority,
//     required this.completed,
//   });

//   @override
//   List<Object?> get props =>
//       [id, title, description, dueDate, priority, completed];
// }

// class DeleteTask extends TaskEvent {
//   final String id;

//   const DeleteTask(this.id);

//   @override
//   List<Object?> get props => [id];
// }
