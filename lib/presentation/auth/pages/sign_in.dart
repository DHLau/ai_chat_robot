import 'package:ai_chat_robot/common/helper/navigator/app_navigator.dart';
import 'package:ai_chat_robot/presentation/auth/bloc/auth_cubit.dart';
import 'package:ai_chat_robot/presentation/auth/bloc/auth_state.dart';
import 'package:ai_chat_robot/presentation/home/pages/chat_gpt_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const Center(
                child: CircularProgressIndicator(color: Colors.grey),
              ),
            );
          } else if (state is AuthSuccess) {
            Navigator.of(context, rootNavigator: true).pop(); // 关闭dialog
            AppNavigator.pushReplacement(context, const ChatGptHome());
          } else if (state is AuthFailure) {
            Navigator.of(context, rootNavigator: true).pop(); // 关闭dialog
            var snackBar = SnackBar(content: Text(state.message));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        child: Scaffold(
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
                        '欢迎回来',
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
                          controller: _emailController,
                          cursorColor: Color(0xff4769ef),
                          // 输入文本的样式
                          style: TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            floatingLabelStyle: TextStyle(
                              color: Color(0xff4769ef),
                            ),
                            labelText: '电子邮箱地址', // 左上角的输入框的提示文本
                            hintText: '电子邮箱地址', // 输入框的提示文本
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        height: 60,
                        child: TextField(
                          controller: _passwordController,
                          cursorColor: Color(0xff4769ef),
                          style: TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            floatingLabelStyle: TextStyle(
                              color: Color(0xff4769ef),
                            ),
                            labelText: '密码', // 左上角的输入框的提示文本
                            hintText: '密码', // 输入框的提示文本
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      Builder(
                        builder: (context) => GestureDetector(
                          onTap: () {
                            if (_emailController.text.isEmpty) {
                              var snackBar = SnackBar(
                                content: Text("请输入电子邮箱地址"),
                              );
                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(snackBar);
                              return;
                            }
                            if (_passwordController.text.isEmpty) {
                              var snackBar = SnackBar(content: Text("请输入密码"));
                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(snackBar);
                              return;
                            }
                            context.read<AuthCubit>().signIn(
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Text(
                                "登录",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
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
        ),
      ),
    );
  }
}
