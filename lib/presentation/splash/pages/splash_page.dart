import 'package:ai_chat_robot/common/helper/navigator/app_navigator.dart';
import 'package:ai_chat_robot/common/helper/widget/ring.dart';
import 'package:ai_chat_robot/presentation/home/bloc/drawer_cubit.dart';
import 'package:ai_chat_robot/presentation/home/bloc/drawer_progress_cubit.dart';
import 'package:ai_chat_robot/presentation/home/pages/chat_gpt_home.dart';
import 'package:ai_chat_robot/presentation/splash/bloc/splash_cubit.dart';
import 'package:ai_chat_robot/presentation/splash/bloc/splash_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          AppNavigator.pushReplacement(
            context,
            MultiBlocProvider(
              providers: [
                BlocProvider<DrawerProgressCubit>(
                  create: (context) => DrawerProgressCubit(),
                ),
                BlocProvider<DrawerCubit>(create: (context) => DrawerCubit()),
              ],
              child: ChatGptHome(),
            ),
          );
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFA7BAFF), // 渐变起始色
                Color(0xFFDFE4FE), // 渐变结束色
              ], // 渐变结束色],
            ),
          ),
          child: SafeArea(
            child: Container(
              padding: const EdgeInsets.only(top: 100),
              alignment: Alignment.topCenter,
              child: _buildSplashImage(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSplashImage() {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 360,
          height: 360,
          child: RingWithGap(
            diameterCm: 1.0,
            strokeWidth: 2.0,
            color: Colors.white.withValues(alpha: 0.4),
            startAngleDeg: 200, // 让开口朝下
            sweepAngleDeg: 300, // 显示300度，留60度开口
          ),
        ),
        SizedBox(
          width: 330,
          height: 330,
          child: RingWithGap(
            diameterCm: 1.0,
            strokeWidth: 2.0,
            color: Colors.white.withValues(alpha: 0.4),
            startAngleDeg: 10, // 让开口朝下
            sweepAngleDeg: 300, // 显示300度，留60度开口
          ),
        ),
        SizedBox(
          width: 300,
          height: 300,
          child: RingWithGap(
            diameterCm: 1.0,
            strokeWidth: 2.0,
            color: Colors.white.withValues(alpha: 0.4),
            startAngleDeg: 100, // 让开口朝下
            sweepAngleDeg: 300, // 显示300度，留60度开口
          ),
        ),
        Image.asset('assets/images/splash.png', width: 220, height: 220),
      ],
    );
  }
}
