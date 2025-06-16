import 'package:ai_chat_robot/domain/chat/entities/chat_message_entity.dart';
import 'package:ai_chat_robot/domain/chat/entities/chat_pair_entity.dart';
import 'package:ai_chat_robot/domain/chat/usecase/chat_save_message_usecase.dart';
import 'package:ai_chat_robot/domain/chat/usecase/chat_usecase.dart';
import 'package:ai_chat_robot/presentation/chat/bloc/chat_state.dart';
import 'package:ai_chat_robot/service_locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  String newestMessageId = '';

  void sendMessage(String message) async {
    final userMessage = ChatMessageEntity(
      id: Uuid().v4(),
      content: message,
      isUser: true,
      isError: false,
    );
    // emit(ChatLoading([...state.messages, userMessage]));
    newestMessageId = userMessage.id;
    emit(ChatLoading([...state.messages, userMessage]));

    var returedData = await sl<ChatUseCase>().call(params: message);
    returedData.fold(
      (l) {
        newestMessageId = l.id;
        emit(ChatSuccess([...state.messages, l]));

        // 保存聊天记录
        var currentPairsMessage = ChatPairsEntity(
          id: newestMessageId,
          createdDate: Timestamp.now(),
          userEntity: userMessage,
          aiEntity: l,
        );
        sl<ChatSaveMessageUsecase>().call(params: currentPairsMessage);
      },
      (r) {
        newestMessageId = r.id;
        emit(ChatError([...state.messages, r]));
      },
    );
  }

  void resetNewestMessageId() {
    newestMessageId = '';
  }
}
