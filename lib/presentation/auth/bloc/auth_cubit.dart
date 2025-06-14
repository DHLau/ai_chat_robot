import 'package:ai_chat_robot/domain/auth/usecase/auth_signin_with_google.dart';
import 'package:ai_chat_robot/presentation/auth/bloc/auth_state.dart';
import 'package:ai_chat_robot/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void signInWithGoogle() async {
    var returnedData = await sl<AuthSigninWithGoogleUseCase>().call();
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
