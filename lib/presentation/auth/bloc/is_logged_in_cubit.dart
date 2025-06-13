import 'package:ai_chat_robot/domain/auth/usecase/is_logged_in.dart';
import 'package:ai_chat_robot/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IsLoggedInCubit extends Cubit<bool> {
  IsLoggedInCubit() : super(false);

  void checkIsLoggedIn() async {
    var isLoggedIn = await sl<IsLoggedInUseCase>().call();
    if (isLoggedIn) {
      emit(true);
    } else {
      emit(false);
    }
  }
}
