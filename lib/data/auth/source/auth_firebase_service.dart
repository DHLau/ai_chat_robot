import 'package:ai_chat_robot/data/auth/models/user_creation_req.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthFirebaseService {
  Future<Either> signup(UserCreationReq userCreationReq);
  Future<Either> signin(UserCreationReq userCreationReq);
  Future<Either> signout();
  Future<Either> signinWithGoogle();
  Future<bool> isLoggedIn();
  Future<Either> getUser();
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
  Future<Either> signin(UserCreationReq userCreationReq) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: userCreationReq.email,
        password: userCreationReq.password,
      );
      return Right('Signin was successful');
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'invalid-email') {
        message = 'The email provided is not valid.';
      } else if (e.code == 'invalid-credential') {
        message = 'Wrong password provided for that user.';
      }
      return Left(message);
    }
  }

  @override
  Future<Either> signup(UserCreationReq userCreationReq) async {
    try {
      var returnedData = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: userCreationReq.email,
            password: userCreationReq.password,
          );
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(returnedData.user!.uid)
          .set({
            'userId': returnedData.user!.uid,
            'userName': userCreationReq.username,
          });
      return Right('Sign up was successful');
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      }
      return Left(message);
    } catch (e) {
      // 捕获 Firestore 或其他未知错误
      return Left('Sign up failed: ${e.toString()}');
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    if (FirebaseAuth.instance.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<Either> signout() async {
    try {
      await FirebaseAuth.instance.signOut();
      return Right(true);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either> getUser() async {
    try {
      var currentUser = FirebaseAuth.instance.currentUser;
      var userData = await FirebaseFirestore.instance
          .collection('Users')
          .doc(currentUser?.uid)
          .get()
          .then((value) => value.data());
      return Right(userData);
    } catch (e) {
      return const Left('Please try again');
    }
  }
}
