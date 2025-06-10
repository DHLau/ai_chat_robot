import 'package:ai_chat_robot/core/configs/theme/app_colors.dart';
import 'package:ai_chat_robot/presentation/chat/bloc/chat_cubit.dart';
import 'package:ai_chat_robot/presentation/chat/bloc/chat_state.dart';
import 'package:ai_chat_robot/presentation/chat/widgets/ai_bubble.dart';
import 'package:ai_chat_robot/presentation/chat/widgets/user_%20bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => ChatCubit(),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFA7BAFF), // 渐变起始色
                    Color(0xFFDFE4FE), // 渐变结束色
                  ], // 渐变结束色],
                ),
              ),
              child: BlocBuilder<ChatCubit, ChatState>(
                builder: (context, state) {
                  if (state is ChatInitial) {
                    return Container();
                  }
                  return SafeArea(
                    child: Container(
                      child: Expanded(
                        child: ListView.separated(
                          itemBuilder: (ctx, index) {
                            final messageEntity = state.messages[index];
                            if (messageEntity.isUser) {
                              return UserBubble(
                                chatMessageEntity: messageEntity,
                              );
                            } else {
                              return AIBubble(chatMessageEntity: messageEntity);
                            }
                          },
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 10),
                          itemCount: state.messages.length,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            _buildLeftBackBtn(),
            _buildInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildInput() {
    return SafeArea(
      child: Builder(
        builder: (context) => Container(
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: TextField(
            style: TextStyle(color: AppColors.titleBlack),
            controller: _controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white.withValues(alpha: 0.4),
              hintText: 'Ask Somthing Else',
              hintStyle: TextStyle(color: Colors.black.withValues(alpha: 0.4)),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              suffixIcon: IconButton(
                icon: Icon(Icons.send),
                color: Colors.black,
                onPressed: () {
                  BlocProvider.of<ChatCubit>(
                    context,
                  ).sendMessage(_controller.text);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLeftBackBtn() {
    return SafeArea(
      child: Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.only(top: 10, left: 16),
        child: Builder(
          builder: (context) => Container(
            alignment: Alignment.center,
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.4),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              iconSize: 30,
              padding: EdgeInsets.zero,
              icon: Icon(Icons.arrow_back),
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
    );
  }
}
