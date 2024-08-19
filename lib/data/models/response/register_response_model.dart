import 'dart:convert';

class RegisterResponseModel {
  final String message;
  final User user;
  final String token;

  RegisterResponseModel({
    required this.message,
    required this.user,
    required this.token,
  });

  factory RegisterResponseModel.fromJson(String str) =>
      RegisterResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RegisterResponseModel.fromMap(Map<String, dynamic> json) =>
      RegisterResponseModel(
        message: json['message'],
        user: User.fromMap(json['user']),
        token: json['token'],
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "user": user.toMap(),
        "token": token,
      };
}

class User {
  final String name;
  final String email;
  final String updatedAt;
  final String createdAt;
  final int id;
  final String profilePhotoUrl;

  User({
    required this.name,
    required this.email,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
    required this.profilePhotoUrl,
  });

  factory User.fromMap(Map<String, dynamic> map) => User(
        name: map['name'],
        email: map['email'],
        updatedAt: map['updated_at'],
        createdAt: map['created_at'],
        id: map['id'],
        profilePhotoUrl: map['profile_photo_url'],
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'email': email,
        'updated_at': updatedAt,
        'created_at': createdAt,
        'id': id,
        'profile_photo_url': profilePhotoUrl,
      };
}
