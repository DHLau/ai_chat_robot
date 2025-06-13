import 'package:flutter/material.dart';

class MenuView extends StatelessWidget {
  final VoidCallback onTapClose;

  const MenuView({required this.onTapClose});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 250,
      padding: EdgeInsets.only(top: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 用户信息区域
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white24,
                  radius: 24,
                  child: Icon(Icons.person, color: Colors.black, size: 30),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "用户",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "免费账户",
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Divider(color: Colors.black, height: 1),

          // 新对话按钮
          ListTile(
            leading: Icon(Icons.add, color: Colors.black),
            title: Text("新对话", style: TextStyle(color: Colors.black)),
            onTap: () {},
          ),

          // 历史记录
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, bottom: 8),
            child: Text(
              "历史记录",
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
          ),

          // 历史对话列表（示例）
          ListTile(
            dense: true,
            leading: Icon(
              Icons.chat_bubble_outline,
              color: Colors.black,
              size: 20,
            ),
            title: Text("关于Flutter的问题", style: TextStyle(color: Colors.black)),
            onTap: () {},
          ),
          ListTile(
            dense: true,
            leading: Icon(
              Icons.chat_bubble_outline,
              color: Colors.white70,
              size: 20,
            ),
            title: Text("如何学习Dart语言", style: TextStyle(color: Colors.black)),
            onTap: () {},
          ),

          Spacer(),

          Divider(color: Colors.white24, height: 1),

          // 底部菜单
          ListTile(
            leading: Icon(Icons.settings, color: Colors.black),
            title: Text("设置", style: TextStyle(color: Colors.black)),
            onTap: onTapClose,
          ),
          ListTile(
            leading: Icon(Icons.info_outline, color: Colors.black),
            title: Text("关于", style: TextStyle(color: Colors.black)),
            onTap: onTapClose,
          ),

          SizedBox(height: 20),
        ],
      ),
    );
  }
}
