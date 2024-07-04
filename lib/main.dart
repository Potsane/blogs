import 'package:blogs/common/cubits/auth_session_cubit.dart';
import 'package:blogs/injection/init_dependancies.dart';
import 'package:blogs/ui/bloc/auth_bloc.dart';
import 'package:blogs/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ui/signin/signin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<AuthSessionCubit>()),
        BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthCurrentSession());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      theme: AppTheme.appLightTheme,
      home: BlocSelector<AuthSessionCubit, AuthSessionState, bool>(
        selector: (state) {
          return state is AuthSessionLoggedIn;
        },
        builder: (context, isLoggedIn) {
          if (isLoggedIn) {
            return const Scaffold(
              body: Center(child: Text("User Logged In!")),
            );
          }
          return const SignInScreen();
        },
      ),
      //home: const SignInScreen(),
    );
  }
}
