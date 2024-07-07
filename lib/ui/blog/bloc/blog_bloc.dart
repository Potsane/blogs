import 'dart:io';

import 'package:blogs/domain/blog/enitity/upload_blog_args.dart';
import 'package:blogs/domain/blog/usecase/upload_blog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';

part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog uploadBlog;

  BlogBloc(this.uploadBlog) : super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<Upload>(_onBlogUpload);
  }

  void _onBlogUpload(Upload event, Emitter<BlogState> emit) async {
    final result = await uploadBlog(
      UploadBlogArgs(
        userId: event.userId,
        title: event.title,
        content: event.content,
        image: event.image,
        topics: event.topics,
      ),
    );

    result.fold(
      (error) => emit(BlogFailure(errorMessage: error.errorMessage)),
      (blog) => emit(BlogSuccess()),
    );
  }
}
