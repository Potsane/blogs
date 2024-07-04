import 'package:blogs/common/cubits/auth_session_cubit.dart';
import 'package:blogs/common/keys/app_keys.dart';
import 'package:blogs/data/datasource/remote/auth_remote_data_source.dart';
import 'package:blogs/data/repository/auth_repository_impl.dart';
import 'package:blogs/domain/repository/auth/auth_repository.dart';
import 'package:blogs/domain/usecases/current_profile.dart';
import 'package:blogs/domain/usecases/user_sign_in.dart';
import 'package:blogs/domain/usecases/user_sign_up.dart';
import 'package:blogs/ui/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();

  final supabase = await Supabase.initialize(
    url: AppKeys.supabaseUrl,
    anonKey: AppKeys.supabaseAnonKey,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);

  //core
  serviceLocator.registerLazySingleton(() => AuthSessionCubit());
}

void _initAuth() {
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        supabaseClient: serviceLocator(),
      ),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        remoteDataSource: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserSignUp(
        repository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserSignIn(
        repository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => CurrentProfile(
        repository: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userSignIn: serviceLocator(),
        currentProfile: serviceLocator(),
        authSessionCubit: serviceLocator(),
      ),
    );
}
