import 'package:ai_chat_robot/presentation/homeV2/bloc/drawer_cubit.dart';
import 'package:ai_chat_robot/presentation/homeV2/pages/main_view.dart';
import 'package:ai_chat_robot/presentation/homeV2/pages/menu_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart'; // 加这个用于 HapticFeedback

class ChatGptHome extends StatefulWidget {
  const ChatGptHome({super.key});

  @override
  State<ChatGptHome> createState() => _ChatGptHomeState();
}

class _ChatGptHomeState extends State<ChatGptHome> {
  final ScrollController _controller = ScrollController();
  double _dragStartX = 0.0;
  bool _hapticTriggered = false;

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
      _controller.jumpTo(MediaQuery.of(context).size.width * 0.7);
    });
  }

  void _handleDragUpdate(DragUpdateDetails details, double menuWidth) {
    final delta = details.primaryDelta ?? 0;
    _controller.jumpTo((_controller.offset - delta).clamp(0.0, menuWidth));

    // 震动反馈：只有一次（例如偏移低于 10 时触发一次）
    if (!_hapticTriggered && _controller.offset <= 10) {
      HapticFeedback.selectionClick(); // 或 mediumImpact、heavyImpact
      _hapticTriggered = true;
    }
  }

  void _handleDragEnd(DragEndDetails details, double menuWidth) {
    final currentOffset = _controller.offset;
    final threshold = menuWidth / 2;

    final isOpen = currentOffset < threshold;

    context.read<DrawerCubit>().setDrawer(isOpen);

    _hapticTriggered = false; // 重置震动
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final menuWidth = screenWidth * 0.7;

    return Scaffold(
      body: BlocProvider(
        create: (_) => DrawerCubit(),
        child: BlocListener<DrawerCubit, bool>(
          listener: (context, isOpen) {
            final targetOffset = isOpen ? 0.0 : menuWidth;
            _controller.animateTo(
              targetOffset,
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeInOut,
            );
          },
          child: Builder(
            builder: (context) => GestureDetector(
              onHorizontalDragUpdate: (details) =>
                  _handleDragUpdate(details, menuWidth),
              onHorizontalDragEnd: (details) =>
                  _handleDragEnd(details, menuWidth),
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
                      child: MainView(
                        onMenuPressed: () {
                          context.read<DrawerCubit>().drawerToggle();
                        },
                      ),
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
}
