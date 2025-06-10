import 'package:ai_chat_robot/common/widgets/type_writer.dart';
import 'package:ai_chat_robot/core/configs/theme/app_colors.dart';
import 'package:ai_chat_robot/domain/chat/entities/chat_message_entity.dart';
import 'package:ai_chat_robot/presentation/chat/bloc/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AIBubble extends StatelessWidget {
  final ChatMessageEntity chatMessageEntity;
  final ScrollController scrollController;

  const AIBubble({
    super.key,
    required this.chatMessageEntity,
    required this.scrollController,
  });

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
              child:
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
                      charDuration: Duration(milliseconds: 50),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
/*
AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          textStyle: TextStyle(color: AppColors.titleBlack),
                          chatMessageEntity.content,
                          speed: const Duration(milliseconds: 50),
                        ),
                      ],
                      totalRepeatCount: 1,
                      pause: const Duration(milliseconds: 500),
                      displayFullTextOnTap: true,
                      stopPauseOnTap: true,
                      onFinished: () {
                        context.read<ChatCubit>().resetNewestMessageId();
                      },
                    ),
*/