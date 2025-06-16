import 'package:ai_chat_robot/domain/chat/entities/chat_pair_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ChatRespository {
  Future<Either> sendMessage(String message);
  Future<Either> saveCurrentPairsEntities(ChatPairsEntity pairsEntities);
}
