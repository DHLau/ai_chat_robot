import 'package:ai_chat_robot/core/usecase/usecase.dart';
import 'package:ai_chat_robot/domain/auth/repository/auth_repository.dart';
import 'package:ai_chat_robot/service_locator.dart';

class AuthSigninWithGoogleUseCase extends UseCase<dynamic, void> {
  @override
  Future call({void params}) async {
    return await sl<AuthRepository>().signinWithGoogle();
  }
}
