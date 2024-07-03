import 'package:blogs/domain/entity/profile.dart';
import 'package:blogs/domain/entity/user_sign_in_args.dart';
import 'package:blogs/domain/entity/user_sign_up_args.dart';
import 'package:blogs/domain/usecases/user_sign_in.dart';
import 'package:blogs/domain/usecases/user_sign_up.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;

  AuthBloc({
    required UserSignUp userSignUp,
    required UserSignIn userSignIn,
  })  : _userSignUp = userSignUp,
        _userSignIn = userSignIn,
        super(AuthInitial()) {
    on<AuthSingUp>(_onSignUp);
    on<AuthSignIn>(_onSignIn);
  }

  void _onSignIn(AuthSignIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final response = await _userSignIn(
      UserSignInArgs(
        email: event.email,
        password: event.password,
      ),
    );
    response.fold(
      (error) => emit(AuthFailure(error.errorMessage)),
      (profile) => emit(AuthSuccess(profile)),
    );
  }

  void _onSignUp(AuthSingUp event, Emitter<AuthState> emit) async {
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
  }
}
