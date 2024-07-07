import 'package:blogs/common/cubits/auth_session_cubit.dart';
import 'package:blogs/domain/auth/entity/empty_args.dart';
import 'package:blogs/domain/auth/entity/profile.dart';
import 'package:blogs/domain/auth/entity/user_sign_in_args.dart';
import 'package:blogs/domain/auth/entity/user_sign_up_args.dart';
import 'package:blogs/domain/auth/usecase/current_profile.dart';
import 'package:blogs/domain/auth/usecase/user_sign_in.dart';
import 'package:blogs/domain/auth/usecase/user_sign_up.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;
  final CurrentProfile _currentProfile;
  final AuthSessionCubit _authSessionCubit;

  AuthBloc({
    required UserSignUp userSignUp,
    required UserSignIn userSignIn,
    required CurrentProfile currentProfile,
    required AuthSessionCubit authSessionCubit,
  })  : _userSignUp = userSignUp,
        _userSignIn = userSignIn,
        _currentProfile = currentProfile,
        _authSessionCubit = authSessionCubit,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSingUp>(_onSignUp);
    on<AuthSignIn>(_onSignIn);
    on<AuthCurrentSession>(_onGetCurrentSession);
  }

  void _onGetCurrentSession(
    AuthCurrentSession event,
    Emitter<AuthState> emit,
  ) async {
    final response = await _currentProfile(EmptyArgs());
    response.fold(
      (error) => emit(AuthFailure(error.errorMessage)),
      (profile) => _emitAuthSuccess(profile, emit),
    );
  }

  void _onSignIn(AuthSignIn event, Emitter<AuthState> emit) async {
    final response = await _userSignIn(
      UserSignInArgs(
        email: event.email,
        password: event.password,
      ),
    );
    response.fold(
      (error) => emit(AuthFailure(error.errorMessage)),
      (profile) => _emitAuthSuccess(profile, emit),
    );
  }

  void _onSignUp(AuthSingUp event, Emitter<AuthState> emit) async {
    final response = await _userSignUp(
      UserSignUpArgs(
        username: event.username,
        email: event.email,
        password: event.password,
      ),
    );
    response.fold(
      (error) => emit(AuthFailure(error.errorMessage)),
      (profile) => _emitAuthSuccess(profile, emit),
    );
  }

  void _emitAuthSuccess(Profile profile, Emitter<AuthState> emit) {
    _authSessionCubit.updateUser(profile);
    emit(AuthSuccess(profile));
  }
}
