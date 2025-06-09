import 'package:ai_chat_robot/presentation/home/bloc/tool_bar_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToolBarCubit extends Cubit<ToolBarState> {
  ToolBarCubit() : super(TooBarStateSpeaker());

  void switchToMarco() {
    emit(TooBarStateMarco());
  }

  void switchToKeyboard() {
    emit(TooBarStateKeyboard());
  }

  void switchToSpeaker() {
    emit(TooBarStateSpeaker());
  }
}
