import 'package:blogs/domain/auth/entity/empty_args.dart';
import 'package:blogs/ui/blog/add_new_blog_screen.dart';
import 'package:blogs/ui/widgets/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/blog_bloc.dart';

class BlogScreen extends StatefulWidget {
  static router() =>
      MaterialPageRoute(builder: (context) => const BlogScreen());

  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(
          EventGetAllBlogs(args: EmptyArgs()),
        );
  }

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
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Loader();
          }
          if (state is BlogsFetchSuccess) {
            return ListView.builder(
              itemCount: state.blogs.length,
              itemBuilder: (context, index) {
                final blog = state.blogs[index];
                return Text(blog.title);
              },
            );
          }
          return const Center(
            child: Text("There are currently no blogs"),
          );
        },
      ),
    );
  }
}
