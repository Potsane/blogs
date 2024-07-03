import 'package:blogs/ui/bloc/auth_bloc.dart';
import 'package:blogs/ui/sign_up/sign_up.dart';
import 'package:blogs/ui/widgets/filled_button.dart';
import 'package:blogs/ui/widgets/loader.dart';
import 'package:blogs/ui/widgets/outlined_text_input.dart';
import 'package:blogs/ui/widgets/show_snackbar.dart';
import 'package:blogs/ui/widgets/two_part_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static router() => MaterialPageRoute(builder: (ctc) => const SignInScreen());

  @override
  State<StatefulWidget> createState() {
    return _SignInScreenState();
  }
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 96, horizontal: 16),
        child: SingleChildScrollView(
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
              return Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Let's Sign you in.",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Welcome back\nYou've been missed!",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 48),
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
                      text: "Sign in",
                      onClick: () {
                        if (formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                                AuthSignIn(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                ),
                              );
                        }
                      },
                    ),
                    const SizedBox(height: 8),
                    TwoPartRichText(
                      partOne: "Don't have an account?",
                      partTwo: "Sign up",
                      onClick: () {
                        Navigator.push(context, SignUpScreen.router());
                      },
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
