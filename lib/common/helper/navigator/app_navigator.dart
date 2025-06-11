import 'package:flutter/material.dart';

class AppNavigator {
  // 当前页面完成后，只需跳转到一个新页面，且不希望用户返回当前页面。
  static void pushReplacement(BuildContext context, Widget page) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => page,
        transitionDuration: const Duration(milliseconds: 300),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // 淡入淡出效果
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  static void push(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  // 你希望跳转到某个页面，并清空栈中所有（或部分）页面，防止用户“返回到过去”。
  static void pushandRemove(BuildContext context, Widget page) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => page),
      (route) => false,
    );
  }
}
