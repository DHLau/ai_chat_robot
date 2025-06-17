import 'package:ai_chat_robot/core/usecase/usecase.dart';
import 'package:ai_chat_robot/domain/auth/repository/auth_repository.dart';
import 'package:ai_chat_robot/service_locator.dart';
import 'package:dartz/dartz.dart';

class SignOutUseCase extends UseCase<Either, void> {
  @override
  Future<Either> call({void params}) async {
    return await sl<AuthRepository>().signout();
  }
}
