import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ai_chat_robot/presentation/auth/bloc/is_logged_in_cubit.dart';
import 'package:ai_chat_robot/presentation/chat/bloc/chat_cubit.dart';
import 'package:ai_chat_robot/presentation/chat/bloc/chat_state.dart';
import 'package:ai_chat_robot/presentation/chat/widgets/ai_bubble.dart';
import 'package:ai_chat_robot/presentation/chat/widgets/user_%20bubble.dart';
import 'package:ai_chat_robot/presentation/home/bloc/drawer_progress_cubit.dart';
import 'package:ai_chat_robot/presentation/chat/widgets/chat_app_bar.dart';
import 'package:ai_chat_robot/presentation/chat/widgets/chat_input.dart';

class ChatPage extends StatefulWidget {
  final VoidCallback onMenuPressed;

  const ChatPage({super.key, required this.onMenuPressed});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ChatCubit()),
          BlocProvider(
            create: (context) => IsLoggedInCubit()..checkIsLoggedIn(),
          ),
        ],
        child: BlocBuilder<DrawerProgressCubit, double>(
          builder: (context, state) => GestureDetector(
            onTap: () {
              if (state == 0.0) {
                widget.onMenuPressed();
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color.lerp(
                  const Color(0xffe0e0e0),
                  Colors.white,
                  context.read<DrawerProgressCubit>().state.clamp(0.0, 1.0),
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    ChatAppBar(onMenuPressed: widget.onMenuPressed),
                    Expanded(child: _buildMessageList()),
                    ChatInput(
                      controller: _controller,
                      onMenuPressed: widget.onMenuPressed,
                      onSendMessage: _handleSendMessage,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMessageList() {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        if (state is ChatInitial) {
          return const SizedBox();
        }
        return ListView.separated(
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(vertical: 10),
          itemCount: state.messages.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final message = state.messages[index];
            return message.isUser
                ? UserBubble(
                    chatMessageEntity: message,
                    scrollController: _scrollController,
                  )
                : AIBubble(
                    chatMessageEntity: message,
                    scrollController: _scrollController,
                  );
          },
        );
      },
    );
  }

  void _handleSendMessage() {
    if (_controller.text.isNotEmpty) {
      context.read<ChatCubit>().sendMessage(_controller.text);
      _controller.clear();
    }
  }
}
