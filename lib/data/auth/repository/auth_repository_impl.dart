import 'package:ai_chat_robot/data/auth/models/user_creation_req.dart';
import 'package:ai_chat_robot/data/auth/models/user_model.dart';
import 'package:ai_chat_robot/data/auth/source/auth_firebase_service.dart';
import 'package:ai_chat_robot/domain/auth/entities/user_entity.dart';
import 'package:ai_chat_robot/domain/auth/repository/auth_repository.dart';
import 'package:ai_chat_robot/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Either> signinWithGoogle() async {
    final returnData = await sl<AuthFirebaseService>().signinWithGoogle();
    return returnData.fold((l) => left(l), (r) {
      UserCredential userCredential = r;
      if (userCredential.user != null) {
        final entity = UserEntity(
          userId: userCredential.user!.uid,
          userName: userCredential.user!.displayName ?? '',
          email: userCredential.user!.email ?? '',
        );
        return right(entity);
      }
      return left('Error');
    });
  }

  @override
  Future<Either> signin(UserCreationReq userCreationReq) async {
    return await sl<AuthFirebaseService>().signin(userCreationReq);
  }

  @override
  Future<Either> signup(UserCreationReq userCreationReq) async {
    return await sl<AuthFirebaseService>().signup(userCreationReq);
  }

  @override
  Future<bool> isLoggedIn() async {
    return await sl<AuthFirebaseService>().isLoggedIn();
  }

  @override
  Future<Either> signout() async {
    return await sl<AuthFirebaseService>().signout();
  }

  @override
  Future<Either> getUser() async {
    var user = await sl<AuthFirebaseService>().getUser();
    return user.fold(
      (error) {
        return Left(error);
      },
      (data) {
        return Right(UserModel.fromMap(data).toEntity());
      },
    );
  }
}
