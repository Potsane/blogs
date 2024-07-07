import 'dart:io';

import 'package:blogs/domain/auth/entity/empty_args.dart';
import 'package:blogs/domain/blog/enitity/blog.dart';
import 'package:blogs/domain/blog/enitity/upload_blog_args.dart';
import 'package:blogs/domain/blog/usecase/get_all_blogs.dart';
import 'package:blogs/domain/blog/usecase/upload_blog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';

part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog uploadBlog;
  final GetAllBlogs getAllBlogs;

  BlogBloc(this.uploadBlog, this.getAllBlogs) : super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<EventUploadBlog>(_onBlogUpload);
    on<EventGetAllBlogs>(_onGetAllBlogs);
  }

  void _onGetAllBlogs(EventGetAllBlogs event, Emitter<BlogState> emit) async {
    final response = await getAllBlogs(event.args);
    response.fold(
      (error) => emit(BlogFailure(errorMessage: error.errorMessage)),
      (blogs) => emit(BlogsFetchSuccess(blogs: blogs)),
    );
  }

  void _onBlogUpload(EventUploadBlog event, Emitter<BlogState> emit) async {
    final response = await uploadBlog(
      UploadBlogArgs(
        userId: event.userId,
        title: event.title,
        content: event.content,
        image: event.image,
        topics: event.topics,
      ),
    );

    response.fold(
      (error) => emit(BlogFailure(errorMessage: error.errorMessage)),
      (blog) => emit(BlogUploadSuccess()),
    );
  }
}
