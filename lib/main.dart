import 'package:flutter/material.dart';
import 'package:kenali_app/screens/splash_screen.dart';
import 'package:kenali_app/screens/login_screen.dart';
import 'package:kenali_app/screens/register_screen.dart';
import 'package:kenali_app/screens/welcome_screen.dart';
import 'package:kenali_app/screens/home_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const KenaliApp());
}

class KenaliApp extends StatelessWidget {
  const KenaliApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Poppins',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
