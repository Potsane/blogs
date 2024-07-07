import 'package:blogs/common/cubits/auth_session_cubit.dart';
import 'package:blogs/common/keys/app_keys.dart';
import 'package:blogs/data/auth/datasource/remote/auth_remote_data_source.dart';
import 'package:blogs/data/auth/repository/auth_repository_impl.dart';
import 'package:blogs/data/blog/datasource/remote/blog_remote_data_source.dart';
import 'package:blogs/data/blog/repository/blog_repository_implementation.dart';
import 'package:blogs/domain/auth/repository/auth_repository.dart';
import 'package:blogs/domain/auth/usecase/current_profile.dart';
import 'package:blogs/domain/auth/usecase/user_sign_in.dart';
import 'package:blogs/domain/auth/usecase/user_sign_up.dart';
import 'package:blogs/domain/blog/repository/blog_repository.dart';
import 'package:blogs/domain/blog/usecase/upload_blog.dart';
import 'package:blogs/ui/auth/bloc/auth_bloc.dart';
import 'package:blogs/ui/blog/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuthDependencies();
  _initBlogDependencies();

  final supabase = await Supabase.initialize(
    url: AppKeys.supabaseUrl,
    anonKey: AppKeys.supabaseAnonKey,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);

  //common
  serviceLocator.registerLazySingleton(() => AuthSessionCubit());
}

void _initAuthDependencies() {
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

void _initBlogDependencies() {
  serviceLocator
    ..registerFactory<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImpl(
        supabaseClient: serviceLocator(),
      ),
    )
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImpl(remoteDataSource: serviceLocator()),
    )
    ..registerFactory(
      () => UploadBlog(repository: serviceLocator()),
    )
    ..registerLazySingleton(
      () => BlogBloc(serviceLocator()),
    );
}
