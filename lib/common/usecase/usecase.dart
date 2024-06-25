import 'package:blogs/common/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class Usecase<T, R> {
  Future<Either<Failure, T>> invoke(R r);
}
