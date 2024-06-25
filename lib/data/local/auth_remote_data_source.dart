import 'package:supabase_flutter/supabase_flutter.dart';

import '../../common/error/exceptions.dart';

abstract interface class AuthRemoteDataSource {
  Future<String> signUp({
    required String username,
    required String email,
    required String password,
  });

  Future<String> signIn({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<String> signIn({required String email, required String password}) {
    throw UnimplementedError();
  }

  @override
  Future<String> signUp(
      {required String username,
      required String email,
      required String password}) async {
    try {
      final response = await supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {"username": username},
      );
      if (response.user == null) {
        throw const GeneralNetworkException();
      }
      return response.user!.id;
    } catch (e) {
      throw GeneralNetworkException(errorMessage: e.toString());
    }
  }
}
