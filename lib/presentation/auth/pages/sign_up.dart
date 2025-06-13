import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(16, 16, 0, 0),
                child: Icon(Icons.close, color: Colors.black, size: 32),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(12, 120, 12, 0),
              child: Column(
                children: [
                  const Text(
                    'ChatRobot',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    '创建账户',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    height: 60,
                    child: TextField(
                      cursorColor: Color(0xff4769ef),
                      // 输入文本的样式
                      style: TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        floatingLabelStyle: TextStyle(color: Color(0xff4769ef)),
                        labelText: '电子邮箱地址', // 左上角的输入框的提示文本
                        hintText: '电子邮箱地址', // 输入框的提示文本
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    height: 60,
                    child: TextField(
                      cursorColor: Color(0xff4769ef),
                      style: TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        floatingLabelStyle: TextStyle(color: Color(0xff4769ef)),
                        labelText: '密码', // 左上角的输入框的提示文本
                        hintText: '密码', // 输入框的提示文本
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        "继续",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
