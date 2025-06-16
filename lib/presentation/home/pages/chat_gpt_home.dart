import 'package:ai_chat_robot/presentation/chat/pages/chat_page.dart';
import 'package:ai_chat_robot/presentation/home/bloc/drawer_cubit.dart';
import 'package:ai_chat_robot/presentation/home/bloc/drawer_progress_cubit.dart';
import 'package:ai_chat_robot/presentation/menu/menu_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart'; // 加这个用于 HapticFeedback

class ChatGptHome extends StatefulWidget {
  const ChatGptHome({super.key});

  @override
  State<ChatGptHome> createState() => _ChatGptHomeState();
}

class _ChatGptHomeState extends State<ChatGptHome> {
  final ScrollController _controller = ScrollController();
  int animateTime = 150;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // WidgetsBinding 确保在第一帧渲染后滚动
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.jumpTo(MediaQuery.of(context).size.width * 0.82);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final menuWidth = screenWidth * 0.82;

    return Scaffold(
      body: BlocListener<DrawerCubit, bool>(
        listener: (context, isOpen) {
          final targetOffset = isOpen ? 0.0 : menuWidth;
          _controller.animateTo(
            targetOffset,
            duration: Duration(milliseconds: animateTime),
            curve: Curves.easeInOut,
          );
        },
        child: Builder(
          builder: (context) => NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification notification) {
              final percent = _controller.offset / menuWidth;
              context.read<DrawerProgressCubit>().drawerCurrentPercent(percent);
              if (notification is ScrollEndNotification) {
                HapticFeedback.mediumImpact();
              }

              if (notification is UserScrollNotification) {
                // 确保是 UserScrollNotification 类型
                if (notification.direction == ScrollDirection.idle) {
                  if (_controller.offset < menuWidth / 2) {
                    // 展开菜单
                    _controller.animateTo(
                      0.0,
                      duration: Duration(milliseconds: animateTime),
                      curve: Curves.easeOut,
                    );
                    context.read<DrawerCubit>().setDrawer(true);
                  } else {
                    // 收起菜单
                    _controller.animateTo(
                      menuWidth,
                      duration: Duration(milliseconds: animateTime),
                      curve: Curves.easeOut,
                    );
                    context.read<DrawerCubit>().setDrawer(false);
                  }
                }
              }
              return true;
            },
            child: SingleChildScrollView(
              controller: _controller,
              physics: const ClampingScrollPhysics(), // 去除弹簧效果
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  // MenuView 宽度为屏幕宽度的 70%
                  SizedBox(
                    width: menuWidth,
                    height: screenHeight,
                    child: MenuView(
                      onTapClose: () {
                        context.read<DrawerCubit>().drawerClose();
                      },
                    ),
                  ),
                  // MainView 占满整个屏幕宽度
                  SizedBox(
                    width: screenWidth,
                    height: screenHeight,
                    child: Container(
                      child: ChatPage(
                        onMenuPressed: () {
                          context.read<DrawerCubit>().drawerToggle();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
