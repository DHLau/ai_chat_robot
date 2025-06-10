import 'package:ai_chat_robot/common/widgets/type_writer.dart';
import 'package:ai_chat_robot/domain/chat/entities/chat_message_entity.dart';
import 'package:flutter/material.dart';

class UserBubble extends StatelessWidget {
  final ChatMessageEntity chatMessageEntity;
  final ScrollController scrollController;
  const UserBubble({
    super.key,
    required this.chatMessageEntity,
    required this.scrollController,
  });

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
              child: TypewriterWithScroll(
                style: TextStyle(color: Colors.white, fontSize: 16),
                text: chatMessageEntity.content,
                scrollController: scrollController,
                charDuration: Duration(milliseconds: 0),
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
/*

chatMessageEntity.id !=
                      context.read<ChatCubit>().newestMessageId
                  ? Text(
                      chatMessageEntity.content,
                      style: TextStyle(
                        color: AppColors.titleBlack,
                        fontSize: 16,
                      ),
                    )
                  : TypewriterWithScroll(
                      style: TextStyle(
                        color: AppColors.titleBlack,
                        fontSize: 16,
                      ),
                      text: chatMessageEntity.content,
                      scrollController: scrollController,
                      charDuration: Duration(milliseconds: 0),
                    ),*/