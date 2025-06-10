import 'package:ai_chat_robot/domain/chat/entities/chat_message_entity.dart';

abstract class ChatState {
  final List<ChatMessageEntity> messages;

  ChatState(this.messages);
}

class ChatInitial extends ChatState {
  ChatInitial() : super([]);
}

class ChatLoading extends ChatState {
  ChatLoading(List<ChatMessageEntity> messages) : super(messages);
}

class ChatSuccess extends ChatState {
  ChatSuccess(List<ChatMessageEntity> messages) : super(messages);
}

class ChatError extends ChatState {
  ChatError(List<ChatMessageEntity> messages) : super(messages);
}
