import 'package:flutter/material.dart';

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
              Text(
                "Hello there,",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 16),
              Text(
                "You are welcome \nLet's get you signed you up!",
                style:  Theme.of(context).textTheme.headlineMedium,
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
