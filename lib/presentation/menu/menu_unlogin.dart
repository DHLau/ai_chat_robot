import 'package:ai_chat_robot/core/configs/theme/app_colors.dart';
import 'package:flutter/material.dart';

class MenuViewNotLoggedIn extends StatelessWidget {
  final VoidCallback onTapClose;
  const MenuViewNotLoggedIn({super.key, required this.onTapClose});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12, left: 16),
                child: Row(
                  children: [
                    Icon(Icons.edit_note, color: Colors.black, size: 30),
                    SizedBox(width: 12),
                    Text('新聊天', style: TextStyle(color: Colors.black)),
                  ],
                ),
              ),
              SizedBox(height: 12),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                width: double.infinity,
                height: 1,
                color: Color(0xffe0e0e0),
              ),
              Container(
                padding: EdgeInsets.only(left: 16, top: 16),
                width: double.infinity,
                child: Text(
                  "使用条款",
                  style: TextStyle(color: AppColors.titleGrey),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 16, top: 16),
                width: double.infinity,
                child: Text(
                  "隐私政策",
                  style: TextStyle(color: AppColors.titleGrey),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 16, top: 16),
                width: double.infinity,
                child: Text("设置", style: TextStyle(color: AppColors.titleGrey)),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 16, top: 16),
                width: double.infinity,
                child: Text(
                  "保存您的历史聊天记录, 共享聊天并个性化您的使用体验",
                  style: TextStyle(color: AppColors.titleGrey),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 16, top: 16, right: 16),
                width: double.infinity,
                height: 44,
                decoration: BoxDecoration(color: Colors.black),
                child: Center(
                  child: Text(
                    "注册并登录",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
