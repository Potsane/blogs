import 'dart:io';

class UploadBlogArgs {
  final String userId;
  final String title;
  final String content;
  final File image;
  final List<String> topics;

  UploadBlogArgs({
    required this.userId,
    required this.title,
    required this.content,
    required this.image,
    required this.topics,
  });
}
