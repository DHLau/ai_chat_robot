import 'package:ai_chat_robot/domain/chat/entities/chat_message_entity.dart';
import 'package:flutter/material.dart';

class UserBubble extends StatelessWidget {
  final ChatMessageEntity chatMessageEntity;
  const UserBubble({super.key, required this.chatMessageEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(36, 12, 24, 12),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // 头像
          // 文字气泡
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xff6640FF),
                borderRadius: BorderRadius.circular(23),
              ),
              child: Text(
                chatMessageEntity.content,
                style: const TextStyle(fontSize: 16),
                softWrap: true,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Image.asset('assets/images/header_image.png', width: 32, height: 32),
        ],
      ),
    );
  }
}
