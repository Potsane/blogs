import 'package:blogs/common/error/failures.dart';
import 'package:blogs/domain/entity/profile.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, Profile>> signUp({
    required String username,
    required String email,
    required String password,
  });

  Future<Either<Failure, Profile>> signIn({
    required String email,
    required String password,
  });

  Future<Either<Failure, Profile>> currentProfile();
}
