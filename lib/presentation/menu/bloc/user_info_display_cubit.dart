import 'package:ai_chat_robot/domain/auth/entities/user_entity.dart';
import 'package:ai_chat_robot/domain/auth/usecase/get_user.dart';
import 'package:ai_chat_robot/presentation/menu/bloc/user_info_display_state.dart';
import 'package:ai_chat_robot/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserInfoDisplayCubit extends Cubit<UserInfoDisplayState> {
  UserInfoDisplayCubit() : super(UserInfoLoading());

  void displayUserInfo() async {
    var returnedData = await sl<GetUserUseCase>().call();
    returnedData.fold(
      (error) {
        return emit(UserInfoLoadFailure());
      },
      (data) {
        return emit(UserInfoLoaded(user: data));
      },
    );
  }
}
