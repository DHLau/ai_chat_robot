import 'package:ai_chat_robot/common/helper/navigator/app_navigator.dart';
import 'package:ai_chat_robot/core/configs/theme/app_colors.dart';
import 'package:ai_chat_robot/presentation/auth/bloc/is_logged_in_cubit.dart';
import 'package:ai_chat_robot/presentation/auth/pages/auth_page.dart';
import 'package:ai_chat_robot/presentation/chat/bloc/chat_cubit.dart';
import 'package:ai_chat_robot/presentation/chat/bloc/chat_state.dart';
import 'package:ai_chat_robot/presentation/chat/widgets/ai_bubble.dart';
import 'package:ai_chat_robot/presentation/chat/widgets/user_%20bubble.dart';
import 'package:ai_chat_robot/presentation/homeV2/bloc/drawer_progress_cubit.dart';
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
          builder: (context, state) => Container(
            decoration: BoxDecoration(
              color: Color.lerp(
                Colors.grey,
                Colors.white,
                context.read<DrawerProgressCubit>().state.clamp(0.0, 1.0),
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
            fillColor: Colors.white.withValues(alpha: 0.4),
            hintText: 'Ask something else',
            hintStyle: TextStyle(color: Colors.black.withValues(alpha: 0.4)),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
    );
  }

  Widget _buildTopNaviBar() {
    return Container(
      width: double.infinity,
      height: 44,
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.center,
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.4),
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
              BlocBuilder<IsLoggedInCubit, bool>(
                builder: (context, state) => state == true
                    ? Container(height: 40)
                    : Container(
                        alignment: Alignment.center,
                        height: 40,
                        decoration: BoxDecoration(),
                        child: TextButton(
                          onPressed: () {
                            AppNavigator.push(context, AuthPage());
                          },
                          child: Text(
                            "Sign in",
                            style: TextStyle(
                              color: AppColors.titleBlack,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 2 - 38,
              vertical: 10,
            ),
            width: 100,
            height: 44,
            child: Text(
              "Chat",
              style: TextStyle(
                color: AppColors.titleBlack,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
