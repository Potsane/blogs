import 'package:blogs/common/error/exceptions.dart';
import 'package:blogs/common/error/failures.dart';
import 'package:blogs/data/datasource/remote/auth_remote_data_source.dart';
import 'package:blogs/domain/entity/profile.dart';
import 'package:blogs/domain/repository/auth/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  const AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Profile>> signIn(
      {required String email, required String password}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Profile>> signUp(
      {required String username,
      required String email,
      required String password}) async {
    try {
      final profile = await remoteDataSource.signUp(
        username: username,
        email: email,
        password: password,
      );

      return right(profile);
    } on GeneralNetworkException catch (e) {
      return left(Failure(errorMessage: e.errorMessage));
    }
  }
}
