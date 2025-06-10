import 'package:ai_chat_robot/domain/chat/entities/chat_message_entity.dart';
import 'package:ai_chat_robot/domain/chat/usecase/chat_usecase.dart';
import 'package:ai_chat_robot/presentation/chat/bloc/chat_state.dart';
import 'package:ai_chat_robot/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  void sendMessage(String message) async {
    final userMessage = ChatMessageEntity(
      id: Uuid().v4(),
      content: message,
      isUser: true,
      isError: false,
    );
    emit(ChatLoading([...state.messages, userMessage]));

    var returedData = await sl<ChatUseCase>().call(params: message);
    returedData.fold(
      (l) {
        emit(ChatSuccess([...state.messages, l]));
      },
      (r) {
        emit(ChatError([...state.messages, r]));
      },
    );
  }
}
