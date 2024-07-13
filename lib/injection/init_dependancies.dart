import 'package:blogs/common/cubits/auth_session_cubit.dart';
import 'package:blogs/common/keys/app_keys.dart';
import 'package:blogs/common/network/connection_checker.dart';
import 'package:blogs/data/auth/datasource/local/blog_local_data_source.dart';
import 'package:blogs/data/auth/datasource/remote/auth_remote_data_source.dart';
import 'package:blogs/data/auth/repository/auth_repository_impl.dart';
import 'package:blogs/data/blog/datasource/remote/blog_remote_data_source.dart';
import 'package:blogs/data/blog/repository/blog_repository_implementation.dart';
import 'package:blogs/domain/auth/repository/auth_repository.dart';
import 'package:blogs/domain/auth/usecase/current_profile.dart';
import 'package:blogs/domain/auth/usecase/user_sign_in.dart';
import 'package:blogs/domain/auth/usecase/user_sign_up.dart';
import 'package:blogs/domain/blog/repository/blog_repository.dart';
import 'package:blogs/domain/blog/usecase/get_all_blogs.dart';
import 'package:blogs/domain/blog/usecase/upload_blog.dart';
import 'package:blogs/ui/auth/bloc/auth_bloc.dart';
import 'package:blogs/ui/blog/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initBlogDependencies();
  _initAuthDependencies();

  final supabase = await Supabase.initialize(
    url: AppKeys.supabaseUrl,
    anonKey: AppKeys.supabaseAnonKey,
  );

  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;

  serviceLocator.registerLazySingleton(() => supabase.client);

  serviceLocator.registerLazySingleton(() => Hive.box(name: "blogs"));

  //common
  serviceLocator.registerLazySingleton(() => AuthSessionCubit());
  serviceLocator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(
      internetConnection: InternetConnection(),
    ),
  );
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
        connectionChecker: serviceLocator(),
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
    ..registerFactory<BlogLocalDataSource>(
      () => BlogLocalDataSourceImpl(
        box: serviceLocator(),
      ),
    )
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImpl(
        remoteDataSource: serviceLocator(),
        localDataSource: serviceLocator(),
        connectionChecker: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UploadBlog(repository: serviceLocator()),
    )
    ..registerFactory(() => GetAllBlogs(repository: serviceLocator()))
    ..registerLazySingleton(
      () => BlogBloc(serviceLocator(), serviceLocator()),
    );
}
