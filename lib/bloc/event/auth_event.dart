import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthRegister extends AuthEvent {
  final String username;
  final String email;
  final String password;

  AuthRegister(
      {required this.username, required this.email, required this.password});

  @override
  List<Object?> get props => [username, email, password];
}

class AuthLogin extends AuthEvent {
  final String email;
  final String password;

  AuthLogin({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
