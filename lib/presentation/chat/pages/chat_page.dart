import 'package:ai_chat_robot/core/configs/theme/app_colors.dart';
import 'package:ai_chat_robot/presentation/chat/bloc/chat_cubit.dart';
import 'package:ai_chat_robot/presentation/chat/bloc/chat_state.dart';
import 'package:ai_chat_robot/presentation/chat/widgets/ai_bubble.dart';
import 'package:ai_chat_robot/presentation/chat/widgets/user_%20bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatefulWidget {
  final VoidCallback onMenuPressed;
  ChatPage({super.key, required this.onMenuPressed});

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
  void initState() {
    super.initState();
    // 添加监听器，当消息发送后自动滚动到底部
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });

    // 监听消息列表变化，自动滚动到底部
    context.read<ChatCubit>().stream.listen((state) {
      if (state.messages.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollToBottom();
        });
      }
    });
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOutQuart,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => ChatCubit(),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFA7BAFF), Color(0xFFDFE4FE)],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                _buildTopNaviBar(),
                Expanded(
                  child: BlocBuilder<ChatCubit, ChatState>(
                    builder: (context, state) {
                      if (state is ChatInitial) {
                        return SizedBox();
                      }
                      return ListView.separated(
                        controller: _scrollController,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        physics: const BouncingScrollPhysics(), // 使用BouncingScrollPhysics提供更好的滚动体验
                        itemCount: state.messages.length,
                        separatorBuilder: (_, __) => SizedBox(height: 10),
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
                  ),
                ),
                _buildInput(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInput() {
    return Builder(
      builder: (context) => Container(
        height: 80,
        padding: EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 8),
        child: TextField(
          controller: _controller,
          style: TextStyle(color: AppColors.titleBlack),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withOpacity(0.4), // 修复 withValues 为 withOpacity
            hintText: 'Ask something else',
            hintStyle: TextStyle(color: Colors.black.withOpacity(0.4)), // 修复 withValues 为 withOpacity
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide.none,
            ),
            suffixIcon: IconButton(
              icon: Icon(Icons.send),
              color: Colors.black,
              onPressed: () {
                if (_controller.text.trim().isNotEmpty) {
                  BlocProvider.of<ChatCubit>(
                    context,
                  ).sendMessage(_controller.text);
                  _controller.clear();
                  // 发送消息后滚动到底部
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _scrollToBottom();
                  });
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopNaviBar() {
    return Container(
      width: double.infinity,
      height: 44,
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.center,
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4), // 修复 withValues 为 withOpacity
              shape: BoxShape.circle,
            ),
            child: IconButton(
              iconSize: 25,
              padding: EdgeInsets.zero,
              icon: Icon(Icons.menu),
              color: Colors.black,
              onPressed: widget.onMenuPressed,
            ),
          ),
          Container(
            child: Text(
              "Chat",
              style: TextStyle(
                color: AppColors.titleBlack,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 40, height: 40),
        ],
      ),
    );
  }
}
