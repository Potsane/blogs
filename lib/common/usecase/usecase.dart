import 'package:blogs/common/error/failures.dart';
import 'package:fpdart/fpdart.dart';

/// T - is the response returned by the call() function.
/// P - parameters passed to the call() function.
/// *
abstract interface class Usecase<T, P> {
  Future<Either<Failure, T>> call(P r);
}
