import 'package:blogs/ui/auth/bloc/auth_bloc.dart';
import 'package:blogs/ui/auth/signin/signin.dart';
import 'package:blogs/ui/widgets/filled_button.dart';
import 'package:blogs/ui/widgets/loader.dart';
import 'package:blogs/ui/widgets/outlined_text_input.dart';
import 'package:blogs/ui/widgets/show_snackbar.dart';
import 'package:blogs/ui/widgets/two_part_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static router() => MaterialPageRoute(builder: (ctc) => const SignUpScreen());

  @override
  State<StatefulWidget> createState() {
    return _SignUpScreenState();
  }
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    userNameController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showSnackBar(context, state.errorMessage);
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Loader();
            }
            return SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello there,",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "You are welcome \nLet's get you signed you up!",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 48),
                    OutlinedTextInput(
                      hint: "Username",
                      controller: userNameController,
                    ),
                    const SizedBox(height: 16),
                    OutlinedTextInput(
                      hint: "Email",
                      controller: emailController,
                    ),
                    const SizedBox(height: 16),
                    OutlinedTextInput(
                      hint: "Password",
                      controller: passwordController,
                      isTextMusked: true,
                    ),
                    const SizedBox(height: 24),
                    FilledDefaultButton(
                      text: "Sign up",
                      onClick: () {
                        if (formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                                AuthSingUp(
                                  email: emailController.text.trim(),
                                  username: userNameController.text.trim(),
                                  password: passwordController.text.trim(),
                                ),
                              );
                        }
                      },
                    ),
                    const SizedBox(height: 8),
                    TwoPartRichText(
                      partOne: "Already have an account?",
                      partTwo: "Sign in",
                      onClick: () {
                        Navigator.pushReplacement(
                            context, SignInScreen.router());
                      },
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
