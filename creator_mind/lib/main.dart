
import 'package:creator_mind/core/di/injection.dart';
import 'package:creator_mind/features/auth/presentation/pages/register_page.dart';
import 'package:creator_mind/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'features/auth/presentation/pages/login_page.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/live/presentation/live_class_page.dart';
import 'firebase_options.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPage(),
        '/login': (context) =>const LoginPage(),
        '/register': (context) =>const RegisterPage(),
        '/home': (context) => const HomePage(),
        '/live': (_) => const LiveClassPage(),
      },
    );
  }
}



