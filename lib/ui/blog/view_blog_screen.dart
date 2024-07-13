import 'package:blogs/domain/blog/enitity/blog.dart';
import 'package:blogs/ui/theme/app_pallete.dart';
import 'package:blogs/util/calculate_reading_time.dart';
import 'package:blogs/util/formatt_date.dart';
import 'package:flutter/material.dart';

class ViewBlogScreen extends StatelessWidget {
  static router(Blog blog) => MaterialPageRoute(
      builder: (context) => ViewBlogScreen(
            blog: blog,
          ));
  final Blog blog;

  const ViewBlogScreen({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                blog.title,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: AppPallete.lightBlue700),
              ),
              const SizedBox(height: 16),
              Text(
                "Written by ${blog.userName!}",
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                "${formatDate(blog.updatedAt)}, ${calculateReadingTime(blog.content)} minute read",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppPallete.lightBlue300,
                    ),
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(blog.imageUrl),
              ),
              const SizedBox(height: 16),
              Text(
                blog.content,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      fontWeight: FontWeight.normal,
                      color: AppPallete.grey900,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
