import 'package:blogs/common/error/exceptions.dart';
import 'package:blogs/data/auth/model/profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Session? get currentUserSession;

  Future<ProfileModel> signUp({
    required String username,
    required String email,
    required String password,
  });

  Future<ProfileModel> signIn({
    required String email,
    required String password,
  });

  Future<ProfileModel?> getCurrentProfile();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<ProfileModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );
      if (response.user == null) {
        throw const GeneralNetworkException();
      }
      return ProfileModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw GeneralNetworkException(errorMessage: e.toString());
    }
  }

  @override
  Future<ProfileModel> signUp(
      {required String username,
      required String email,
      required String password}) async {
    try {
      final response = await supabaseClient.auth.signUp(
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

  @override
  Future<ProfileModel?> getCurrentProfile() async {
    try {
      if (currentUserSession == null) return null;
      final userProfile = await supabaseClient
          .from('profiles')
          .select()
          .eq('id', currentUserSession!.user.id);
      return ProfileModel.fromJson(userProfile.first)
          .copyWith(email: currentUserSession!.user.email);
    } catch (e) {
      throw GeneralNetworkException(errorMessage: e.toString());
    }
  }
}
