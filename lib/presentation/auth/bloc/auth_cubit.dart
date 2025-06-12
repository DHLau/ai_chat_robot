import 'package:ai_chat_robot/domain/auth/repository/auth_repository.dart';
import 'package:ai_chat_robot/presentation/auth/bloc/auth_state.dart';
import 'package:ai_chat_robot/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void signInWithGoogle() async {
    var returnedData = await sl<AuthRepository>().signinWithGoogle();
    returnedData.fold(
      (l) {
        emit(AuthFailure(l));
      },
      (r) {
        emit(AuthSuccess(r));
      },
    );
  }
}
