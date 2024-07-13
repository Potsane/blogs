import 'package:blogs/domain/blog/enitity/blog.dart';
import 'package:blogs/ui/blog/view_blog_screen.dart';
import 'package:blogs/ui/theme/app_pallete.dart';
import 'package:blogs/util/calculate_reading_time.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;

  const BlogCard({
    super.key,
    required this.blog,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          ViewBlogScreen.router(blog),
        );
      },
      child: Container(
        height: 200,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppPallete.blueGray50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: blog.topics
                    .map(
                      (tag) => Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Chip(
                          color: const WidgetStatePropertyAll(Colors.white),
                          label: Text(tag),
                          side: const BorderSide(
                            color: AppPallete.lightBlue700,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              blog.title,
              maxLines: 2,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: AppPallete.lightBlue700),
            ),
            const SizedBox(height: 16),
            Text(
              " ${calculateReadingTime(blog.content)} minutes read",
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: AppPallete.lightBlue100),
            ),
          ],
        ),
      ),
    );
  }
}
