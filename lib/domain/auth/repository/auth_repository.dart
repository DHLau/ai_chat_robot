import 'package:ai_chat_robot/data/auth/models/user_creation_req.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either> signup(UserCreationReq userCreationReq);
  Future<Either> signin(UserCreationReq userCreationReq);
  Future<Either> signout();
  Future<Either> signinWithGoogle();
  Future<bool> isLoggedIn();
  Future<Either> getUser();
}
