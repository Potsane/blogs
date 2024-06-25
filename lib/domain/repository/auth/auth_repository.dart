import 'package:blogs/common/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, String>> signUp({
    required String username,
    required String email,
    required String password,
  });

  Future<Either<Failure, String>> signIn({
    required String email,
    required String password,
  });
}
