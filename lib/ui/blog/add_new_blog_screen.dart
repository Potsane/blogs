import 'dart:io';

import 'package:blogs/common/cubits/auth_session_cubit.dart';
import 'package:blogs/ui/blog/bloc/blog_bloc.dart';
import 'package:blogs/ui/blog/blog_screen.dart';
import 'package:blogs/ui/theme/app_pallete.dart';
import 'package:blogs/ui/widgets/loader.dart';
import 'package:blogs/ui/widgets/pick_image.dart';
import 'package:blogs/ui/widgets/show_snackbar.dart';
import 'package:blogs/ui/widgets/untitled_outlined_text_input.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewBlogScreen extends StatefulWidget {
  static router() => MaterialPageRoute(
        builder: (context) => const AddNewBlogScreen(),
      );

  const AddNewBlogScreen({super.key});

  @override
  State<AddNewBlogScreen> createState() => _AddNewBlogScreenState();
}

class _AddNewBlogScreenState extends State<AddNewBlogScreen> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<String> selectedTags = [];
  File? image;

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              _uploadBlog(context);
            },
            icon: const Icon(Icons.done_rounded),
          )
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackBar(context, state.errorMessage);
          } else if (state is BlogUploadSuccess) {
            //Navigator.pushAndRemoveUntil(context, BlogScreen.router());
            Navigator.pushReplacement(context, BlogScreen.router());
          }
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Loader();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    image != null
                        ? GestureDetector(
                            onTap: () {
                              selectImage();
                            },
                            child: SizedBox(
                              width: double.infinity,
                              height: 150,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  image!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              selectImage();
                            },
                            child: DottedBorder(
                              color: AppPallete.lightBlue700,
                              dashPattern: const [16, 4],
                              radius: const Radius.circular(8),
                              borderType: BorderType.RRect,
                              strokeCap: StrokeCap.round,
                              child: SizedBox(
                                height: 150,
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.folder_open,
                                      size: 48,
                                      color: AppPallete.lightBlue300,
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      "Pick image",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .copyWith(
                                            fontWeight: FontWeight.normal,
                                            color: AppPallete.lightBlue700,
                                          ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                    const SizedBox(height: 16),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          "Technology",
                          "Business",
                          "Programming",
                          "Entertainment",
                        ]
                            .map(
                              (tag) => Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (selectedTags.contains(tag)) {
                                        selectedTags.remove(tag);
                                      } else {
                                        selectedTags.add(tag);
                                      }
                                    });
                                  },
                                  child: Chip(
                                    color: selectedTags.contains(tag)
                                        ? const WidgetStatePropertyAll(
                                            AppPallete.pelorous)
                                        : const WidgetStatePropertyAll(
                                            Colors.white),
                                    label: Text(tag),
                                    side: const BorderSide(
                                      color: AppPallete.lightBlue700,
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    UntitledOutlinedTextInput(
                      hint: "Blog Title",
                      controller: titleController,
                    ),
                    const SizedBox(height: 16),
                    UntitledOutlinedTextInput(
                      hint: "Blog Content",
                      controller: contentController,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _uploadBlog(BuildContext context) {
    if (formKey.currentState!.validate() &&
        selectedTags.isNotEmpty &&
        image != null) {
      final userId =
          (context.read<AuthSessionCubit>().state as AuthSessionLoggedIn)
              .profile
              .id;

      context.read<BlogBloc>().add(
            EventUploadBlog(
              image: image!,
              title: titleController.text.trim(),
              content: contentController.text.trim(),
              userId: userId,
              topics: selectedTags,
            ),
          );
    }
  }
}
