// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:ai_chat_robot/data/chat/models/chat_message_model.dart';
import 'package:ai_chat_robot/domain/chat/entities/chat_pair_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPairsModel {
  String id;
  final Timestamp createdDate;
  final ChatMessageModel userMessage;
  final ChatMessageModel aiMessage;

  ChatPairsModel({
    required this.id,
    required this.createdDate,
    required this.userMessage,
    required this.aiMessage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdDate': createdDate,
      'userMessage': userMessage.toMap(),
      'aiMessage': aiMessage.toMap(),
    };
  }

  String toJson() => json.encode(toMap());
}

extension ChatPairsModelXEntity on ChatPairsEntity {
  ChatPairsModel fromEntity() {
    return ChatPairsModel(
      id: id,
      createdDate: createdDate,
      userMessage: userEntity.fromEntity(),
      aiMessage: userEntity.fromEntity(),
    );
  }
}
