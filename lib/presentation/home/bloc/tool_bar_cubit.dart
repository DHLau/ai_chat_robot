import 'package:ai_chat_robot/presentation/home/bloc/tool_bar_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToolBarCubit extends Cubit<ToolBarState> {
  ToolBarCubit() : super(TooBarStateMarco());

  void switchToMarco(VoidCallback onAnimationEnd) {
    emit(TooBarStateMarco());
    Future.delayed(Duration(milliseconds: 300), onAnimationEnd); // 动画结束后调用
  }

  void switchToKeyboard(VoidCallback onAnimationEnd) {
    emit(TooBarStateKeyboard());
    Future.delayed(Duration(milliseconds: 300), onAnimationEnd); // 动画结束后调用
  }

  void switchToSpeaker() {
    emit(TooBarStateSpeaker());
  }
}
