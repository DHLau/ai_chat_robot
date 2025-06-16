// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ai_chat_robot/domain/chat/entities/chat_message_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPairsEntity {
  String id;
  final Timestamp createdDate;
  final ChatMessageEntity userEntity;
  final ChatMessageEntity aiEntity;

  ChatPairsEntity({
    required this.id,
    required this.createdDate,
    required this.userEntity,
    required this.aiEntity,
  });
}
