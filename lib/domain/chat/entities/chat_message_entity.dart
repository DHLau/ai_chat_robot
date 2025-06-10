class ChatMessageEntity {
  final String id;
  final String content;
  final bool isUser;
  final bool isError;

  ChatMessageEntity({
    required this.id,
    required this.content,
    required this.isUser,
    required this.isError,
  });
}
