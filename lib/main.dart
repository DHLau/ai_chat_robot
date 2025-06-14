import 'package:ai_chat_robot/core/configs/theme/app_theme.dart';
import 'package:ai_chat_robot/firebase_options.dart';
import 'package:ai_chat_robot/presentation/splash/bloc/splash_cubit.dart';
import 'package:ai_chat_robot/presentation/splash/pages/splash_page.dart';
import 'package:ai_chat_robot/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit()..appStart(),
      child: MaterialApp(home: const SplashPage(), theme: AppTheme.appTheme),
    );
  }
}
