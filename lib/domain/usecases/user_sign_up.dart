import 'package:blogs/common/error/failures.dart';
import 'package:blogs/common/usecase/usecase.dart';
import 'package:blogs/domain/entity/profile.dart';
import 'package:blogs/domain/entity/user_sign_up_args.dart';
import 'package:blogs/domain/repository/auth/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class UserSignUp implements Usecase<Profile, UserSignUpArgs> {
  final AuthRepository repository;

  const UserSignUp({required this.repository});

  @override
  Future<Either<Failure, Profile>> call(UserSignUpArgs args) async {
    return await repository.signUp(
      username: args.username,
      email: args.email,
      password: args.password,
    );
  }
}