import 'package:ai_chat_robot/core/configs/theme/app_colors.dart';
import 'package:ai_chat_robot/domain/chat/entities/chat_message_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class AIBubble extends StatelessWidget {
  final ChatMessageEntity chatMessageEntity;
  const AIBubble({super.key, required this.chatMessageEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 12, 36, 12),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // 头像
          Image.asset('assets/images/header_image.png', width: 32, height: 32),
          const SizedBox(width: 8),
          // 文字气泡
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    Color.fromRGBO(
                      149,
                      172,
                      255,
                      0.34,
                    ), // rgba(149,172,255,0.34)
                    Color.fromRGBO(253, 177, 255, 0.2),
                    Color.fromRGBO(254, 212, 255, 0.37),
                    Color.fromRGBO(254, 212, 255, 0.37),
                    Color.fromRGBO(253, 177, 255, 0.2),
                    Color.fromRGBO(149, 172, 255, 0.34),
                  ],
                  stops: [0.0, 0.28, 0.44, 0.61, 0.81, 0.99],
                ),
                borderRadius: BorderRadius.circular(23),
              ),
              child: Text(
                chatMessageEntity.content,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.titleBlack,
                ),
                softWrap: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
