import 'package:blogs/common/keys/app_keys.dart';
import 'package:blogs/ui/bloc/auth_bloc.dart';
import 'package:blogs/ui/login/login.dart';
import 'package:blogs/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'data/local/auth_remote_data_source.dart';
import 'data/repository/auth_repository_impl.dart';
import 'domain/usecases/user_sign_up.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final supabase = await Supabase.initialize(
    url: AppKeys.supabaseUrl,
    anonKey: AppKeys.supabaseAnonKey,
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(
            userSignUp: UserSignUp(
              repository: AuthRepositoryImpl(
                remoteDataSource: AuthRemoteDataSourceImpl(supabase: supabase),
              ),
            ),
          ),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      theme: AppTheme.appLightTheme,
      home: const LoginScreen(),
    );
  }
}
