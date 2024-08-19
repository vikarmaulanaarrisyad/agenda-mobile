import 'dart:convert';

class LoginResponseModel {
  final String token;
  final User user;

  LoginResponseModel({
    required this.token,
    required this.user,
  });

  factory LoginResponseModel.fromJson(String str) =>
      LoginResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginResponseModel.fromMap(Map<String, dynamic> json) =>
      LoginResponseModel(
        token: json['token'],
        user: User.fromMap(json['data']),
      );

  Map<String, dynamic> toMap() => {
        'token': token,
        'data': user.toMap(),
      };
}

class User {
  final int id;
  final String name;
  final String email;
  final String createdAt;
  final String updatedAt;
  final String profilePhotoUrl;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
    required this.profilePhotoUrl,
  });

  factory User.fromMap(Map<String, dynamic> map) => User(
        id: map['id'],
        name: map['name'],
        email: map['email'],
        createdAt: map['created_at'],
        updatedAt: map['updated_at'],
        profilePhotoUrl: map['profile_photo_url'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'email': email,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'profile_photo_url': profilePhotoUrl,
      };
}
