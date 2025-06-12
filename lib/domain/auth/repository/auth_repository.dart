import 'package:ai_chat_robot/data/auth/models/user_creation_req.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either> signup(UserCreationReq userCreationReq);
}
