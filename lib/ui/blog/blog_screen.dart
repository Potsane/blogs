import 'package:blogs/ui/blog/add_new_blog_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlogScreen extends StatelessWidget {
  static router() =>
      MaterialPageRoute(builder: (context) => const BlogScreen());

  const BlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blog App"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, AddNewBlogScreen.router());
            },
            icon: const Icon(CupertinoIcons.add_circled),
          )
        ],
      ),
    );
  }
}
