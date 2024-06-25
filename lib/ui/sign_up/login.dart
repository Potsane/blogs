import 'package:blogs/ui/sign_up/sign_up.dart';
import 'package:flutter/material.dart';

import '../widgets/filled_button.dart';
import '../widgets/outlined_text_input.dart';
import '../widgets/two_part_rich_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static router() => MaterialPageRoute(builder: (ctc) => const LoginScreen());

  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
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
          child: Form(
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
                  onClick: () {},
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
          ),
        ),
      ),
    );
  }
}
