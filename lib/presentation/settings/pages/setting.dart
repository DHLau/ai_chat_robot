import 'package:ai_chat_robot/common/helper/navigator/app_navigator.dart';
import 'package:ai_chat_robot/common/widgets/appbar/app_bar.dart';
import 'package:ai_chat_robot/presentation/auth/bloc/auth_cubit.dart';
import 'package:ai_chat_robot/presentation/auth/bloc/auth_state.dart';
import 'package:ai_chat_robot/presentation/home/pages/chat_gpt_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLogout) {
            AppNavigator.pushReplacement(context, const ChatGptHome());
          }
        },
        child: Scaffold(
          appBar: BasicAppBar(title: Text("设置")),
          body: Builder(
            builder: (context) => SingleChildScrollView(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.read<AuthCubit>().signout();
                    },
                    child: Text("退出登录"),
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
