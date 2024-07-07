import 'package:blogs/domain/auth/entity/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_session_state.dart';

class AuthSessionCubit extends Cubit<AuthSessionState> {
  AuthSessionCubit() : super(AuthSessionInitial());

  void updateUser(Profile? profile) {
    if (profile == null) {
      emit(AuthSessionInitial());
    } else {
      emit(AuthSessionLoggedIn(profile: profile));
    }
  }
}
