part of 'auth_session_cubit.dart';

@immutable
sealed class AuthSessionState {}

final class AuthSessionInitial extends AuthSessionState {}

final class AuthSessionLoggedIn extends AuthSessionState {
  final Profile profile;

  AuthSessionLoggedIn({required this.profile});
}
