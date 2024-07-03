import 'package:blogs/domain/entity/profile.dart';
import 'package:blogs/domain/entity/user_sign_up_entity.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/user_sign_up.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;

  AuthBloc({required UserSignUp userSignUp})
      : _userSignUp = userSignUp,
        super(AuthInitial()) {
    on<AuthSingUp>((event, emit) async {
      //run this when we receive this event...
      emit(AuthLoading());
      final response = await _userSignUp(
        UserSignUpArgs(
          username: event.username,
          email: event.email,
          password: event.password,
        ),
      );

      response.fold(
        (error) => emit(AuthFailure(error.errorMessage)),
        (profile) => emit(AuthSuccess(profile)),
      );
    });
  }
}
