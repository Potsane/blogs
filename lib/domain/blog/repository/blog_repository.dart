import 'dart:io';

import 'package:blogs/common/error/failures.dart';
import 'package:blogs/domain/blog/enitity/blog.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String userId,
    required List<String> topics,
  });
}
