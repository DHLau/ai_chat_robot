import 'package:ai_chat_robot/presentation/chat/bloc/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:ai_chat_robot/core/configs/theme/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ai_chat_robot/presentation/home/bloc/drawer_progress_cubit.dart';

class ChatInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onMenuPressed;

  const ChatInput({
    super.key,
    required this.controller,
    required this.onMenuPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 8),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        color: Color.lerp(
          const Color(0xffe0e0e0),
          Colors.white,
          context.read<DrawerProgressCubit>().state.clamp(0.0, 1.0),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0xffe0e0e0),
            blurRadius: 12,
            offset: Offset(0, -12),
          ),
        ],
      ),
      child: Column(
        children: [_buildTextField(context), _buildActionButtons(context)],
      ),
    );
  }

  Widget _buildTextField(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: AppColors.titleBlack),
      decoration: InputDecoration(
        hintText: 'Ask something else',
        fillColor: Color.lerp(
          const Color(0xffe0e0e0),
          Colors.white,
          context.read<DrawerProgressCubit>().state.clamp(0.0, 1.0),
        ),
        hintStyle: TextStyle(color: Colors.black.withOpacity(0.4)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        border: _getInputBorder(),
        enabledBorder: _getInputBorder(),
        focusedBorder: _getInputBorder(),
        focusedErrorBorder: _getInputBorder(),
      ),
    );
  }

  OutlineInputBorder _getInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            _buildIconButton(Icons.add, onMenuPressed),
            _buildIconButton(Icons.menu_open, onMenuPressed),
          ],
        ),
        Row(
          children: [
            _buildIconButton(Icons.macro_off, onMenuPressed),
            _buildIconButton(Icons.send, () {
              if (controller.text.isNotEmpty) {
                context.read<ChatCubit>().sendMessage(controller.text);
                controller.clear();
              }
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onPressed) {
    return Container(
      width: 40,
      height: 40,
      child: IconButton(
        iconSize: 25,
        padding: EdgeInsets.zero,
        icon: Icon(icon),
        color: Colors.black,
        onPressed: onPressed,
      ),
    );
  }
}
