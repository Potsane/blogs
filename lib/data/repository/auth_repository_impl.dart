import 'package:blogs/common/error/exceptions.dart';
import 'package:blogs/common/error/failures.dart';
import 'package:blogs/data/datasource/remote/auth_remote_data_source.dart';
import 'package:blogs/domain/entity/profile.dart';
import 'package:blogs/domain/repository/auth/auth_repository.dart';
import 'package:fpdart/src/either.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  const AuthRepositoryImpl({required this.remoteDataSource});

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

  Future<Either<Failure, Profile>> _getProfile(
      Future<Profile> Function() block) async {
    try {
      final profile = await block();
      return right(profile);
    } on AuthException catch (e) {
      return left(Failure(errorMessage: e.message));
    } on GeneralNetworkException catch (e) {
      return left(Failure(errorMessage: e.errorMessage));
    }
  }
}
