import 'dart:io';

import 'package:blogs/common/error/exceptions.dart';
import 'package:blogs/data/blog/model/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blog);

  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  });
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final SupabaseClient supabaseClient;

  BlogRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      final response =
          await supabaseClient.from("blogs").insert(blog.toJson()).select();
      return BlogModel.fromJson(response.first);
    } catch (e) {
      throw const GeneralNetworkException();
    }
  }

  @override
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  }) async {
    try {
      await supabaseClient.storage.from("blog_images").upload(
            blog.id,
            image,
          );
      return supabaseClient.storage.from("blog_images").getPublicUrl(blog.id);
    } catch (e) {
      throw const GeneralNetworkException();
    }
  }
}
