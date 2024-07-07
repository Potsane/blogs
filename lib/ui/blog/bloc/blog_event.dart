part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

final class EventUploadBlog extends BlogEvent {
  final String userId;
  final String title;
  final String content;
  final File image;
  final List<String> topics;

  EventUploadBlog({
    required this.image,
    required this.title,
    required this.content,
    required this.userId,
    required this.topics,
  });
}

final class EventGetAllBlogs extends BlogEvent {
  final EmptyArgs args;

  EventGetAllBlogs({required this.args});

}
