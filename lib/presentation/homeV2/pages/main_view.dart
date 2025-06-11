import 'package:flutter/material.dart';

class MainView extends StatelessWidget {
  final VoidCallback onMenuPressed;
  const MainView({required this.onMenuPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0, // 移除Material自带的阴影，因为我们已经在外层添加了阴影
      color: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            AppBar(
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.menu),
                onPressed: onMenuPressed,
              ),
              title: Text("AI Chat Robot"),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              actions: [
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {},
                ),
              ],
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {}, // 空手势，用于接收点击事件
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.chat_bubble_outline, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        "开始新对话",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "点击左上角菜单按钮或从左侧边缘滑动打开菜单",
                        style: TextStyle(color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
