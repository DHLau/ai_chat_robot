// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:ai_chat_robot/domain/chat/entities/chat_message_entity.dart';

class ChatMessageModel {
  final String id;
  final String content;
  final bool isUser;
  final bool isError;

  ChatMessageModel({
    required this.id,
    required this.content,
    required this.isUser,
    required this.isError,
  });
}

extension ChatMessageModelX on ChatMessageModel {
  ChatMessageEntity toEntity() {
    return ChatMessageEntity(
      id: id,
      content: content,
      isUser: isUser,
      isError: isError,
    );
  }
}
