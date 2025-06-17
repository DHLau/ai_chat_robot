import 'package:ai_chat_robot/data/auth/models/user_creation_req.dart';
import 'package:ai_chat_robot/domain/auth/usecase/auth_signin_with_google.dart';
import 'package:ai_chat_robot/domain/auth/usecase/sign_in_with_email.dart';
import 'package:ai_chat_robot/domain/auth/usecase/sign_out.dart';
import 'package:ai_chat_robot/domain/auth/usecase/sign_up_with_email.dart';
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

  void signIn({required String email, required String password}) async {
    emit(AuthLoading());
    var returnedData = await sl<SignInWithEmailUseCase>().call(
      params: UserCreationReq(email: email, password: password),
    );
    returnedData.fold(
      (l) {
        emit(AuthFailure(l));
      },
      (r) {
        emit(AuthSuccess(r));
      },
    );
  }

  void signUp(String email, String password, String username) async {
    emit(AuthLoading());
    var returnedData = await sl<SignUpWithEmailUseCase>().call(
      params: UserCreationReq(
        email: email,
        password: password,
        username: username,
      ),
    );
    returnedData.fold(
      (l) {
        emit(AuthFailure(l));
      },
      (r) {
        emit(AuthSuccess(r));
      },
    );
  }

  void signout() async {
    emit(AuthLoading());
    var returnedData = await sl<SignOutUseCase>().call();
    returnedData.fold(
      (l) {
        emit(AuthFailure(l));
      },
      (r) {
        emit(AuthLogout());
      },
    );
  }
}
