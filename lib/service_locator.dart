import 'package:ai_chat_robot/data/chat/repository/chat_respository_impl.dart';
import 'package:ai_chat_robot/data/chat/source/chat_open_router_service.dart';
import 'package:ai_chat_robot/domain/chat/repository/chat_respository.dart';
import 'package:ai_chat_robot/domain/chat/usecase/chat_usecase.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<ChatRespository>(ChatRespositoryImpl());
  sl.registerSingleton<ChatOpenRouterService>(
    ChatOpenRouterServiceImpl(apiKey: dotenv.env['OPENROUTER_API_KEY']!),
  );
  sl.registerSingleton<ChatUseCase>(ChatUseCase());
}
