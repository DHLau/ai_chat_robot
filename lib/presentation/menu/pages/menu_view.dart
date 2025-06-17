import 'package:ai_chat_robot/presentation/auth/bloc/is_logged_in_cubit.dart';
import 'package:ai_chat_robot/presentation/menu/pages/menu_logined.dart';
import 'package:ai_chat_robot/presentation/menu/pages/menu_unlogin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuView extends StatelessWidget {
  final VoidCallback onTapClose;

  const MenuView({required this.onTapClose});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IsLoggedInCubit()..checkIsLoggedIn(),
      child: BlocBuilder<IsLoggedInCubit, bool>(
        builder: (context, state) {
          if (state) {
            return MenuViewLoggedIn(onTapClose: onTapClose);
          } else {
            return MenuViewNotLoggedIn(onTapClose: onTapClose);
          }
        },
      ),
    );
  }
}
