import 'package:ai_chat_robot/common/helper/navigator/app_navigator.dart';
import 'package:ai_chat_robot/presentation/auth/bloc/auth_cubit.dart';
import 'package:ai_chat_robot/presentation/auth/bloc/auth_state.dart';
import 'package:ai_chat_robot/presentation/home/pages/chat_gpt_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
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
          child: SafeArea(
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
                SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(12, 100, 12, 0),
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
                        Container(
                          height: 60,
                          child: TextField(
                            controller: _nameController,
                            cursorColor: Color(0xff4769ef),
                            style: TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              floatingLabelStyle: TextStyle(
                                color: Color(0xff4769ef),
                              ),
                              labelText: '怎么称呼您', // 左上角的输入框的提示文本
                              hintText: '怎么称呼您', // 输入框的提示文本
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
                          child: Builder(
                            builder: (context) => GestureDetector(
                              onTap: () {
                                if (_emailController.text.isEmpty) {
                                  var snackBar = SnackBar(
                                    content: Text("请输入邮箱"),
                                  );
                                  ScaffoldMessenger.of(
                                    context,
                                  ).showSnackBar(snackBar);
                                  return;
                                }
                                if (_passwordController.text.isEmpty) {
                                  var snackBar = SnackBar(
                                    content: Text("请输入密码"),
                                  );
                                  ScaffoldMessenger.of(
                                    context,
                                  ).showSnackBar(snackBar);
                                  return;
                                }
                                if (_nameController.text.isEmpty) {
                                  var snackBar = SnackBar(
                                    content: Text("请输入您的名字"),
                                  );
                                  ScaffoldMessenger.of(
                                    context,
                                  ).showSnackBar(snackBar);
                                  return;
                                }
                                context.read<AuthCubit>().signUp(
                                  _emailController.text,
                                  _passwordController.text,
                                  _nameController.text,
                                );
                              },
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
                          ),
                        ),
                      ],
                    ),
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
