import 'dart:io';

import 'package:blogs/common/error/exceptions.dart';
import 'package:blogs/common/error/failures.dart';
import 'package:blogs/common/network/connection_checker.dart';
import 'package:blogs/data/auth/datasource/local/blog_local_data_source.dart';
import 'package:blogs/data/blog/datasource/remote/blog_remote_data_source.dart';
import 'package:blogs/data/blog/model/blog_model.dart';
import 'package:blogs/domain/blog/enitity/blog.dart';
import 'package:blogs/domain/blog/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource remoteDataSource;
  final BlogLocalDataSource localDataSource;
  final ConnectionChecker connectionChecker;

  BlogRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.connectionChecker,
  });

  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String userId,
    required List<String> topics,
  }) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(Failure(errorMessage: "No internet connection"));
      }

      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(),
        userId: userId,
        title: title,
        content: content,
        imageUrl: "imageUrl",
        topics: topics,
        updatedAt: DateTime.now(),
      );
      final imageUrl = await remoteDataSource.uploadBlogImage(
        image: image,
        blog: blogModel,
      );
      blogModel = blogModel.copyWith(imageUrl: imageUrl);
      final updatedBlog = await remoteDataSource.uploadBlog(blogModel);

      return right(updatedBlog);
    } on GeneralNetworkException catch (e) {
      return left(Failure(errorMessage: e.errorMessage));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async {
    try {
      if (!await connectionChecker.isConnected) {
        final blogs = localDataSource.loadBlogs();
        return right(blogs);
      }

      final blogs = await remoteDataSource.getAllBlogs();
      localDataSource.uploadLocalBlogs(blogs: blogs);
      return right(blogs);
    } on GeneralNetworkException catch (e) {
      return left(Failure(errorMessage: e.errorMessage));
    }
  }
}
