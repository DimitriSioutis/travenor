import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  const SignInRequested(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String username;

  const SignUpRequested(this.username, this.email, this.password);

  @override
  List<Object> get props => [username, email, password];
}

class SignOutRequested extends AuthEvent {}

class CheckAuthStatus extends AuthEvent {}
