import 'package:blogs/common/error/failures.dart';
import 'package:blogs/common/usecase/usecase.dart';
import 'package:blogs/domain/entity/profile.dart';
import 'package:blogs/domain/entity/user_sign_in_args.dart';
import 'package:blogs/domain/repository/auth/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignIn implements Usecase<Profile, UserSignInArgs> {
  final AuthRepository repository;

  UserSignIn({required this.repository});

  @override
  Future<Either<Failure, Profile>> call(UserSignInArgs args) async {
    return await repository.signIn(
      email: args.email,
      password: args.password,
    );
  }
}
