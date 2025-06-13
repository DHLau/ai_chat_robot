import 'package:ai_chat_robot/data/auth/models/user_creation_req.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthFirebaseService {
  Future<Either> signup(UserCreationReq userCreationReq);
  Future<Either> signin(UserCreationReq userCreationReq);
  Future<Either> signinWithGoogle();
  Future<bool> isLoggedIn();
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  @override
  Future<Either> signinWithGoogle() async {
    try {
      // 1. 用户选择 Google 账号
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return Left("用户选择 Google 账号失败");

      // 2. 获取认证凭证
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      // 3. 登录 Firebase
      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );
      return Right(userCredential);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either> signin(UserCreationReq userCreationReq) {
    throw UnimplementedError();
  }

  @override
  Future<Either> signup(UserCreationReq userCreationReq) {
    throw UnimplementedError();
  }

  @override
  Future<bool> isLoggedIn() async {
    if (FirebaseAuth.instance.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }
}
