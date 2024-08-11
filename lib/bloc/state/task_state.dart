import 'package:equatable/equatable.dart';

abstract class TaskState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskSuccess extends TaskState {
  final List<dynamic> tasks;

  TaskSuccess({required this.tasks});

  @override
  List<Object?> get props => [tasks];
}

class TaskFailure extends TaskState {
  final String error;

  TaskFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'task_model.dart';

// abstract class TaskState extends Equatable {
//   const TaskState();

//   @override
//   List<Object?> get props => [];
// }

// class TaskLoading extends TaskState {}

// class TaskLoaded extends TaskState {
//   final List<Task> tasks;

//   const TaskLoaded(this.tasks);

//   @override
//   List<Object?> get props => [tasks];
// }

// class TaskError extends TaskState {
//   final String message;

//   const TaskError(this.message);

//   @override
//   List<Object?> get props => [message];
// }

// class TaskOperationSuccess extends TaskState {
//   final Task task;
//   final String message;

//   const TaskOperationSuccess(this.task, this.message);

//   @override
//   List<Object?> get props => [task, message];
// }

// class TaskOperationFailure extends TaskState {
//   final String message;

//   const TaskOperationFailure(this.message);

//   @override
//   List<Object?> get props => [message];
// }
