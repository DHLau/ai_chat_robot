import 'package:ai_chat_robot/presentation/splash/bloc/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(DisplaySplash());

  void appStart() async {
    await Future.delayed(const Duration(seconds: 2));
    emit(Authenticated());
  }
}
