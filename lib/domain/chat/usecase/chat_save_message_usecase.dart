import 'package:ai_chat_robot/core/usecase/usecase.dart';
import 'package:ai_chat_robot/domain/chat/entities/chat_pair_entity.dart';
import 'package:ai_chat_robot/domain/chat/repository/chat_respository.dart';
import 'package:ai_chat_robot/service_locator.dart';
import 'package:dartz/dartz.dart';

class ChatSaveMessageUsecase extends UseCase<Either, ChatPairsEntity> {
  @override
  Future<Either> call({ChatPairsEntity? params}) {
    return sl<ChatRespository>().saveCurrentPairsEntities(params!);
  }
}
