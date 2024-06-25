import 'package:blogs/common/error/failures.dart';
import 'package:blogs/common/usecase/usecase.dart';
import 'package:blogs/domain/repository/auth/auth_repository.dart';
import 'package:fpdart/src/either.dart';

import '../entity/user_sign_up_entity.dart';

class UserSignUp implements Usecase<String, UserSignUpArgs> {
  final AuthRepository repository;

  const UserSignUp({required this.repository});

  @override
  Future<Either<Failure, String>> invoke(UserSignUpArgs args) async {
    return await repository.signUp(
      username: args.username,
      email: args.email,
      password: args.password,
    );
  }
}