import 'package:flutter/material.dart';

import '../theme/app_pallete.dart';
import '../widgets/outlined_text_input.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SignUpScreenState();
  }
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 96, horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Let's sign you in",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppPallete.mandy,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Welcome back \nYou've been missed!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.normal,
                  color: AppPallete.sweetPink,
                ),
              ),
              const SizedBox(height: 48),
              OutlinedTextInput(
                hint: "Username or Email",
                controller: emailController,
              ),
              const SizedBox(height: 16),
              OutlinedTextInput(
                hint: "Password",
                controller: passwordController,
                isTextMusked: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
