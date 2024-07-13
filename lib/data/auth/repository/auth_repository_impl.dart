import 'package:blogs/common/error/exceptions.dart';
import 'package:blogs/common/error/failures.dart';
import 'package:blogs/common/network/connection_checker.dart';
import 'package:blogs/data/auth/datasource/remote/auth_remote_data_source.dart';
import 'package:blogs/domain/auth/entity/profile.dart';
import 'package:blogs/domain/auth/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final ConnectionChecker connectionChecker;

  const AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.connectionChecker,
  });

  @override
  Future<Either<Failure, Profile>> signIn({
    required String email,
    required String password,
  }) async {
    return _getProfile(
      () async => await remoteDataSource.signIn(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, Profile>> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    return _getProfile(
      () async => await remoteDataSource.signUp(
        username: username,
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, Profile>> currentProfile() async {
    try {
      if (!await connectionChecker.isConnected) {
        final session = remoteDataSource.currentUserSession;
        if (session == null) {
          return left(Failure(errorMessage: "User not logged in!"));
        }
        return right(Profile(
          id: session.user.id,
          email: session.user.email ?? "",
          name: "",
        ));
      }
      final profile = await remoteDataSource.getCurrentProfile();
      if (profile == null) {
        return left(Failure(errorMessage: "User not logged in!"));
      }
      return right(
        Profile(
          id: profile.id,
          email: profile.email,
          name: profile.name,
        ),
      );
    } on GeneralNetworkException catch (e) {
      return left(Failure(errorMessage: e.errorMessage));
    }
  }

  Future<Either<Failure, Profile>> _getProfile(
      Future<Profile> Function() block) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(Failure(errorMessage: "No internet connection"));
      }
      final profile = await block();
      return right(profile);
    } on AuthException catch (e) {
      return left(Failure(errorMessage: e.message));
    } on GeneralNetworkException catch (e) {
      return left(Failure(errorMessage: e.errorMessage));
    }
  }
}
