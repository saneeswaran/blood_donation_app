// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String? id;
  final String name;
  final String email;
  final String password;
  final String? fcmToken;
  final String? authId;
  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    this.fcmToken,
    this.authId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'fcmToken': fcmToken,
      'authId': authId,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      fcmToken: map['fcmToken'] != null ? map['fcmToken'] as String : null,
      authId: map['authId'] != null ? map['authId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
