import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './state/auth_state.dart';
import './state/task_state.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'event/auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final String baseUrl = "http://192.168.70.101:8300/api/auth";
  final _secureStorage = FlutterSecureStorage();

  AuthBloc() : super(AuthInitial()) {
    on<AuthRegister>(_onRegister);
    on<AuthLogin>(_onLogin);
  }

  void _onRegister(AuthRegister event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        body: {
          'username': event.username,
          'email': event.email,
          'password': event.password,
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        emit(AuthSuccess(token: data['token'], userInfo: data['user_info']));
      } else {
        emit(AuthFailure(error: jsonDecode(response.body)['message']));
      }
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }

  void _onLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        // body: {
        //   'email': event.email,
        //   'password': event.password,
        // },
        body: jsonEncode({
          'email': event.email,
          'password': event.password,
        }),
      );
      // print(response.body);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = jsonDecode(response.body);
        // Extract the token
        String token = jsonMap['token'];
        // Extract the user info
        Map<String, dynamic> userInfo = jsonMap['user_info'];
        //  print(token);
        // print(userInfo);
        // Store token and user info in shared preferences
        // final prefs = await SharedPreferences.getInstance();
        // await prefs.setString('token', token);
        // await prefs.setString('userInfo', userInfo.toString());

        // Store token and user info securely
        // await _secureStorage.write(key: 'token', value: token);
        // await _secureStorage.write(key: 'userInfo', value: userInfo.toString());

        // Store token and user info in shared preferences
        // final prefs = await SharedPreferences.getInstance();
        // await prefs.setString('token', token);
        // // await prefs.setString('userInfo', userInfo.toString());
        // await prefs.setString('userInfo',
        //     jsonEncode(userInfo)); // Make sure it's properly encoded

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString('userInfo', jsonEncode(userInfo));

        // final data = jsonDecode(response.body);
        emit(AuthSuccess(token: token, userInfo: userInfo));
      } else {
        emit(AuthFailure(error: jsonDecode(response.body)['error']));
      }
    } catch (e) {
      print(e);
      emit(AuthFailure(error: e.toString()));
    }
  }
}
