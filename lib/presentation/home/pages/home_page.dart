import 'package:ai_chat_robot/common/helper/widget/ring.dart';
import 'package:ai_chat_robot/core/configs/theme/app_colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(context),
      body: Stack(children: [_buildContainer(), _buildLeftMenuBtn()]),
    );
  }

  SafeArea _buildLeftMenuBtn() {
    return SafeArea(
      child: Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.only(top: 10, left: 16),
        child: Builder(
          builder: (context) => Container(
            alignment: Alignment.center,
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.4),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              iconSize: 30,
              padding: EdgeInsets.zero,
              icon: Icon(Icons.menu),
              color: Colors.black,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
        ),
      ),
    );
  }

  Container _buildContainer() {
    return Container(
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
          padding: const EdgeInsets.only(top: 80),
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  _buildSplashImage(),
                  SizedBox(height: 12),
                  _buildTitles(),
                ],
              ),
              Column(children: [_buildFunctionButtons(), _buildTitle()]),
            ],
          ),
        ),
      ),
    );
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.618,
      // 抽屉内容
      child: Container(
        color: Color(0xFF7A5BFE),
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 30),
            children: [
              ListTile(
                leading: Icon(Icons.home),
                title: Text('主页'),
                onTap: () {
                  Navigator.pop(context); // 关闭抽屉
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('设置'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitles() {
    return const Column(
      children: [
        Text(
          "Welcome Back",
          style: TextStyle(color: AppColors.titleGrey, fontSize: 20),
        ),
        Text(
          "How Can I Help You Today?",
          style: TextStyle(
            color: AppColors.titleBlack,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
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

  Widget _buildFunctionButtons() {
    return Row();
  }

  Widget _buildTitle() {
    return Text("Tap To Talk");
  }
}
