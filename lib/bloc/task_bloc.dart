// import 'package:flutter_bloc/flutter_bloc.dart';
// import './state/auth_state.dart';
// import './state/task_state.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'event/task_event.dart';

// class TaskBloc extends Bloc<TaskEvent, TaskState> {
//   final String baseUrl = "http://localhost:8300/api/tasks";
//   final String token;

//   TaskBloc({required this.token}) : super(TaskInitial()) {
//     on<TaskCreate>(_onCreateTask);
//     on<TaskUpdate>(_onUpdateTask);
//     on<TaskDelete>(_onDeleteTask);
//     on<TaskFetchAll>(_onFetchAllTasks);
//   }

//   void _onCreateTask(TaskCreate event, Emitter<TaskState> emit) async {
//     emit(TaskLoading());
//     try {
//       final response = await http.post(
//         Uri.parse(baseUrl),
//         headers: {
//           'Authorization': 'Bearer $token',
//         },
//         body: {
//           'title': event.title,
//           'description': event.description,
//           'dueDate': event.dueDate.toIso8601String(),
//           'priority': event.priority,
//         },
//       );

//       if (response.statusCode == 201) {
//         final data = jsonDecode(response.body);
//         emit(TaskSuccess(tasks: [data['task']]));
//       } else {
//         emit(TaskFailure(error: jsonDecode(response.body)['message']));
//       }
//     } catch (e) {
//       emit(TaskFailure(error: e.toString()));
//     }
//   }

//   void _onUpdateTask(TaskUpdate event, Emitter<TaskState> emit) async {
//     emit(TaskLoading());
//     try {
//       final response = await http.put(
//         Uri.parse('$baseUrl/${event.id}'),
//         headers: {
//           'Authorization': 'Bearer $token',
//         },
//         body: {
//           'title': event.title,
//           'description': event.description,
//           'dueDate': event.dueDate.toIso8601String(),
//           'priority': event.priority,
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         emit(TaskSuccess(tasks: [data['task']]));
//       } else {
//         emit(TaskFailure(error: jsonDecode(response.body)['message']));
//       }
//     } catch (e) {
//       emit(TaskFailure(error: e.toString()));
//     }
//   }

//   void _onDeleteTask(TaskDelete event, Emitter<TaskState> emit) async {
//     emit(TaskLoading());
//     try {
//       final response = await http.delete(
//         Uri.parse('$baseUrl/${event.id}'),
//         headers: {
//           'Authorization': 'Bearer $token',
//         },
//       );

//       if (response.statusCode == 200) {
//         emit(TaskSuccess(tasks: []));
//       } else {
//         emit(TaskFailure(error: jsonDecode(response.body)['message']));
//       }
//     } catch (e) {
//       emit(TaskFailure(error: e.toString()));
//     }
//   }

//   void _onFetchAllTasks(TaskFetchAll event, Emitter<TaskState> emit) async {
//     emit(TaskLoading());
//     try {
//       final response = await http.get(
//         Uri.parse(baseUrl),
//         headers: {
//           'Authorization': 'Bearer $token',
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         emit(TaskSuccess(tasks: data));
//       } else {
//         emit(TaskFailure(error: jsonDecode(response.body)['message']));
//       }
//     } catch (e) {
//       emit(TaskFailure(error: e.toString()));
//     }
//   }
// }

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/model/task_model.dart';
import './state/task_state.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'event/task_event.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final String baseUrl = "http://localhost:8300/api/tasks";

  TaskBloc() : super(TaskInitial()) {
    on<TaskCreate>(_onCreateTask);
    on<TaskUpdate>(_onUpdateTask);
    on<TaskDelete>(_onDeleteTask);
    on<TaskFetchAll>(_onFetchAllTasks);
  }

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> _onCreateTask(TaskCreate event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    final token = await _getToken();
    if (token == null) {
      emit(TaskFailure(error: 'No token found'));
      return;
    }
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {
          'title': event.title,
          'description': event.description,
          'dueDate': event.dueDate.toIso8601String(),
          'priority': event.priority,
        },
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        emit(TaskSuccess(tasks: [data['task']]));
      } else {
        emit(TaskFailure(error: jsonDecode(response.body)['message']));
      }
    } catch (e) {
      emit(TaskFailure(error: e.toString()));
    }
  }

  Future<void> _onUpdateTask(TaskUpdate event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    final token = await _getToken();
    if (token == null) {
      emit(TaskFailure(error: 'No token found'));
      return;
    }
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/${event.id}'),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {
          'title': event.title,
          'description': event.description,
          'dueDate': event.dueDate.toIso8601String(),
          'priority': event.priority,
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        emit(TaskSuccess(tasks: [data['task']]));
      } else {
        emit(TaskFailure(error: jsonDecode(response.body)['message']));
      }
    } catch (e) {
      emit(TaskFailure(error: e.toString()));
    }
  }

  Future<void> _onDeleteTask(TaskDelete event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    final token = await _getToken();
    if (token == null) {
      emit(TaskFailure(error: 'No token found'));
      return;
    }
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/${event.id}'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        emit(TaskSuccess(tasks: []));
      } else {
        emit(TaskFailure(error: jsonDecode(response.body)['message']));
      }
    } catch (e) {
      emit(TaskFailure(error: e.toString()));
    }
  }

  Future<void> _onFetchAllTasks(
      TaskFetchAll event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    final token = await _getToken();
    if (token == null) {
      emit(TaskFailure(error: 'No token found'));
      return;
    }
    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      print(response.body);

      if (response.statusCode == 200) {
        // final data = jsonDecode(response.body);
        // emit(TaskSuccess(tasks: data));
        final List tasks = jsonDecode(response.body);
        emit(TaskSuccess(tasks: tasks.map((e) => Task.fromJson(e)).toList()));
      } else {
        emit(TaskFailure(error: jsonDecode(response.body)['message']));
      }
    } catch (e) {
      emit(TaskFailure(error: e.toString()));
    }
  }
}
