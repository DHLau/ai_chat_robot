import 'package:ai_chat_robot/core/configs/theme/app_colors.dart';
import 'package:ai_chat_robot/presentation/auth/bloc/auth_cubit.dart';
import 'package:ai_chat_robot/presentation/auth/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AuthCubit(),
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return Container(
              color: Colors.white,
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildNaviBar(context),
                      Text(
                        "AIChatRobot",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      _buildBottomBar(context),
                    ],
                  ),
                  state is AuthLoading
                      ? Container(
                          width: double.infinity,
                          height: double.infinity,
                          child: Center(
                            child: const CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildNaviBar(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: 44,
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.withValues(alpha: 0.5),
              ),
              child: IconButton(
                icon: Icon(Icons.close, color: AppColors.titleBlack),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        24,
        24,
        24,
        MediaQuery.of(context).viewPadding.bottom,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: Column(
        children: [
          _buildSigninWithApple(context),
          SizedBox(height: 16),
          _buildSigninWithGoogle(context),
          SizedBox(height: 12),
          _buildSignupWithEmail(context),
          SizedBox(height: 12),
          _buildSigninWithEmail(context),
        ],
      ),
    );
  }

  Widget _buildSigninWithEmail(BuildContext context) {
    return Container(
      height: 44,
      width: MediaQuery.of(context).size.width - 50,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        border: Border.all(color: Color(0xff2c2c2c), width: 3),
      ),
      child: Center(
        child: Text(
          "Sign In",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildSigninWithApple(BuildContext context) {
    return Container(
      height: 44,
      width: MediaQuery.of(context).size.width - 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Center(
        child: Text(
          " Sign In With Apple",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildSignupWithEmail(BuildContext context) {
    return Container(
      height: 44,
      width: MediaQuery.of(context).size.width - 50,
      decoration: BoxDecoration(
        color: Color(0xff2c2c2c),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Center(
        child: Text(
          "Sign Up",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildSigninWithGoogle(BuildContext context) {
    return Container(
      height: 44,
      width: MediaQuery.of(context).size.width - 50,
      decoration: BoxDecoration(
        color: Color(0xff2c2c2c),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/google.png', width: 24, height: 24),
            SizedBox(width: 8),
            Text(
              "Sign In With Google",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
