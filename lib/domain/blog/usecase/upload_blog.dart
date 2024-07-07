import 'package:blogs/common/error/failures.dart';
import 'package:blogs/common/usecase/usecase.dart';
import 'package:blogs/domain/blog/enitity/blog.dart';
import 'package:blogs/domain/blog/enitity/upload_blog_args.dart';
import 'package:blogs/domain/blog/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlog implements Usecase<Blog, UploadBlogArgs> {
  final BlogRepository repository;

  UploadBlog({
    required this.repository,
  });

  @override
  Future<Either<Failure, Blog>> call(UploadBlogArgs args) async {
    return await repository.uploadBlog(
      image: args.image,
      title: args.title,
      content: args.content,
      userId: args.userId,
      topics: args.topics,
    );
  }
}
