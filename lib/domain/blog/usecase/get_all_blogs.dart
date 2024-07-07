import 'package:blogs/common/error/failures.dart';
import 'package:blogs/common/usecase/usecase.dart';
import 'package:blogs/domain/auth/entity/empty_args.dart';
import 'package:blogs/domain/blog/enitity/blog.dart';
import 'package:blogs/domain/blog/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlogs implements Usecase<List<Blog>, EmptyArgs> {
  final BlogRepository repository;

  GetAllBlogs({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<Blog>>> call(EmptyArgs args) async {
    return await repository.getAllBlogs();
  }
}
