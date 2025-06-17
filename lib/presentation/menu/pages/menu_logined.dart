import 'package:ai_chat_robot/common/helper/navigator/app_navigator.dart';
import 'package:ai_chat_robot/presentation/menu/bloc/user_info_display_cubit.dart';
import 'package:ai_chat_robot/presentation/menu/bloc/user_info_display_state.dart';
import 'package:ai_chat_robot/presentation/settings/pages/setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuViewLoggedIn extends StatelessWidget {
  final VoidCallback onTapClose;
  const MenuViewLoggedIn({super.key, required this.onTapClose});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserInfoDisplayCubit()..displayUserInfo(),
      child: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            _buildChatHistoryList(),
            _buildBottomBar(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.only(top: 0, left: 16),
      height: 60,
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 40,
              child: TextField(
                cursorColor: Color(0xffe0e0e0),
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 0,
                  ),
                  hintText: '搜索聊天',
                  hintStyle: TextStyle(color: Colors.grey),
                  fillColor: Color(0xffe0e0e0),
                  filled: true,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 4),
                    child: Icon(Icons.search, size: 20, color: Colors.grey),
                  ),
                  prefixIconConstraints: BoxConstraints(
                    minWidth: 0,
                    minHeight: 0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12), // 圆角
                    borderSide: BorderSide.none, // 无边框
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          Icon(Icons.edit_note, color: Colors.black, size: 30),
        ],
      ),
    );
  }

  Widget _buildChatHistoryList() {
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        itemBuilder: (context, index) {
          return Text("Chat History", style: TextStyle(color: Colors.black));
        },
        separatorBuilder: (context, index) =>
            SizedBox(width: double.infinity, height: 16),
        itemCount: 20,
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return BlocBuilder<UserInfoDisplayCubit, UserInfoDisplayState>(
      builder: (context, state) => GestureDetector(
        onTap: () {
          AppNavigator.modal(context, SettingsPage());
        },
        child: Container(
          padding: EdgeInsets.only(top: 12, left: 16, right: 16, bottom: 0),
          child: Row(
            children: [
              Image(
                image: AssetImage('assets/images/header_image.png'),
                width: 32,
                height: 32,
              ),
              const SizedBox(width: 8),
              state is UserInfoLoaded
                  ? Text(
                      state.user.userName ?? "",
                      style: TextStyle(color: Colors.black),
                    )
                  : Text(""),
            ],
          ),
        ),
      ),
    );
  }
}
