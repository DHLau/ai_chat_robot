import 'package:ai_chat_robot/data/chat/models/chat_message_model.dart';
import 'package:ai_chat_robot/data/chat/source/chat_open_router_service.dart';
import 'package:ai_chat_robot/domain/chat/repository/chat_respository.dart';
import 'package:ai_chat_robot/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:uuid/uuid.dart';

class ChatRespositoryImpl implements ChatRespository {
  final uuid = Uuid();

  Future<Either> sendMessage(String message) async {
    final result = await sl<ChatOpenRouterService>().sendMessage(message);
    return result.fold(
      (error) {
        final ChatMessageModel chatMessageModel = ChatMessageModel(
          id: uuid.v4(),
          content: error,
          isUser: false,
          isError: true,
        );
        return Left(chatMessageModel.toEntity());
      },
      (data) {
        final ChatMessageModel chatMessageModel = ChatMessageModel(
          id: uuid.v4(),
          content: data,
          isUser: false,
          isError: true,
        );
        return Left(chatMessageModel.toEntity());
      },
    );
  }
}
