import 'package:blogs/common/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class Usecase<T, P> {
  Future<Either<Failure, T>> call(P r);
}
