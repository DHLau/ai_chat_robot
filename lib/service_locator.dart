import 'package:ai_chat_robot/data/auth/repository/auth_repository_impl.dart';
import 'package:ai_chat_robot/data/auth/source/auth_firebase_service.dart';
import 'package:ai_chat_robot/data/chat/repository/chat_respository_impl.dart';
import 'package:ai_chat_robot/data/chat/source/chat_open_router_service.dart';
import 'package:ai_chat_robot/domain/auth/repository/auth_repository.dart';
import 'package:ai_chat_robot/domain/auth/usecase/auth_signin_with_google.dart';
import 'package:ai_chat_robot/domain/auth/usecase/is_logged_in.dart';
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

  // auth
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());
  sl.registerSingleton<AuthSigninWithGoogleUseCase>(
    AuthSigninWithGoogleUseCase(),
  );
  sl.registerSingleton<IsLoggedInUseCase>(IsLoggedInUseCase());
}
