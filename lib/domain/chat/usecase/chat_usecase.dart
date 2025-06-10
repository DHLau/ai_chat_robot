import 'package:ai_chat_robot/core/usecase/usecase.dart';
import 'package:ai_chat_robot/domain/chat/repository/chat_respository.dart';
import 'package:ai_chat_robot/service_locator.dart';
import 'package:dartz/dartz.dart';

class ChatUseCase extends UseCase<Either, String> {
  @override
  Future<Either> call({String? params}) async {
    return await sl<ChatRespository>().sendMessage(params!);
  }
}
