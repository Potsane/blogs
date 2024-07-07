import 'package:blogs/common/error/failures.dart';
import 'package:blogs/common/usecase/usecase.dart';
import 'package:blogs/domain/auth/entity/empty_args.dart';
import 'package:blogs/domain/auth/entity/profile.dart';
import 'package:blogs/domain/auth/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CurrentProfile implements Usecase<Profile, EmptyArgs> {
  final AuthRepository repository;

  CurrentProfile({required this.repository});

  @override
  Future<Either<Failure, Profile>> call(EmptyArgs args) async {
    return await repository.currentProfile();
  }
}
