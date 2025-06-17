import 'package:ai_chat_robot/core/usecase/usecase.dart';
import 'package:ai_chat_robot/data/auth/models/user_creation_req.dart';
import 'package:ai_chat_robot/domain/auth/repository/auth_repository.dart';
import 'package:ai_chat_robot/service_locator.dart';
import 'package:dartz/dartz.dart';

class SignUpWithEmailUseCase extends UseCase<Either, UserCreationReq> {
  @override
  Future<Either> call({UserCreationReq? params}) async {
    return await sl<AuthRepository>().signup(params!);
  }
}
