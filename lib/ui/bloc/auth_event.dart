part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSingUp extends AuthEvent {
  final String email;
  final String username;
  final String password;

  AuthSingUp({
    required this.email,
    required this.username,
    required this.password,
  });
}
