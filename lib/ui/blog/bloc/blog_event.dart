part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

final class Upload extends BlogEvent {
  final String userId;
  final String title;
  final String content;
  final File image;
  final List<String> topics;

  Upload({
    required this.image,
    required this.title,
    required this.content,
    required this.userId,
    required this.topics,
  });
}
