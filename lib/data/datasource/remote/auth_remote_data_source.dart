import 'package:blogs/data/model/profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../common/error/exceptions.dart';

abstract interface class AuthRemoteDataSource {
  Future<ProfileModel> signUp({
    required String username,
    required String email,
    required String password,
  });

  Future<ProfileModel> signIn({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Supabase supabase;

  AuthRemoteDataSourceImpl({required this.supabase});

  @override
  Future<ProfileModel> signIn(
      {required String email, required String password}) {
    throw UnimplementedError();
  }

  @override
  Future<ProfileModel> signUp(
      {required String username,
      required String email,
      required String password}) async {
    try {
      final response = await supabase.client.auth.signUp(
        email: email,
        password: password,
        data: {"name": username},
      );
      if (response.user == null) {
        throw const GeneralNetworkException();
      }
      return ProfileModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw GeneralNetworkException(errorMessage: e.toString());
    }
  }
}
