import 'dart:convert';

import 'package:ai_chat_robot/domain/auth/entities/user_entity.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String? userId;
  final String? userName;
  final String? email;

  UserModel({required this.userId, this.userName, this.email});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] != null ? map['userId'] as String : null,
      userName: map['userName'] != null ? map['userName'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
    );
  }
}

extension UserXModel on UserModel {
  UserEntity toEntity() {
    return UserEntity(userId: userId, email: email, userName: userName);
  }
}
