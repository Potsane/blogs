import 'package:blogs/domain/entity/profile.dart';

class ProfileModel extends Profile {
  ProfileModel({
    required super.id,
    required super.email,
    required super.name,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['id'] ?? '',
      email: map["email"] ?? '',
      name: map['name'] ?? '',
    );
  }
}
