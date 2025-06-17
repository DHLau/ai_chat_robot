import 'package:ai_chat_robot/core/usecase/usecase.dart';
import 'package:ai_chat_robot/domain/auth/repository/auth_repository.dart';
import 'package:ai_chat_robot/service_locator.dart';
import 'package:dartz/dartz.dart';

class GetUserUseCase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({dynamic params}) async {
    return await sl<AuthRepository>().getUser();
  }
}
