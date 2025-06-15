import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ai_chat_robot/common/helper/navigator/app_navigator.dart';
import 'package:ai_chat_robot/core/configs/theme/app_colors.dart';
import 'package:ai_chat_robot/presentation/auth/bloc/is_logged_in_cubit.dart';
import 'package:ai_chat_robot/presentation/auth/pages/auth_page.dart';

class ChatAppBar extends StatelessWidget {
  final VoidCallback onMenuPressed;

  const ChatAppBar({super.key, required this.onMenuPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Stack(children: [_buildMainRow(context), _buildTitle(context)]),
    );
  }

  Widget _buildMainRow(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_buildMenuButton(), _buildSignInButton(context)],
    );
  }

  Widget _buildMenuButton() {
    return Container(
      alignment: Alignment.center,
      width: 40,
      height: 40,
      child: IconButton(
        iconSize: 25,
        padding: EdgeInsets.zero,
        icon: const Icon(Icons.menu),
        color: Colors.black,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onPressed: onMenuPressed,
      ),
    );
  }

  Widget _buildSignInButton(BuildContext context) {
    return BlocBuilder<IsLoggedInCubit, bool>(
      builder: (context, state) => state == true
          ? const SizedBox(height: 40)
          : Container(
              alignment: Alignment.center,
              height: 40,
              child: TextButton(
                onPressed: () {
                  AppNavigator.push(context, const AuthPage());
                },
                child: const Text(
                  "Sign in",
                  style: TextStyle(color: AppColors.titleBlack, fontSize: 16),
                ),
              ),
            ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width / 2 - 50,
      ),
      width: 100,
      height: 44,
      child: Center(
        child: const Text(
          "Chat",
          style: TextStyle(
            color: AppColors.titleBlack,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
