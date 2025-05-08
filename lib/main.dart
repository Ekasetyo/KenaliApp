import 'package:flutter/material.dart';
import 'package:kenali_app/screens/splash_screen.dart';
import 'package:kenali_app/screens/login_screen.dart';
import 'package:kenali_app/screens/register_screen.dart';
import 'package:kenali_app/screens/welcome_screen.dart';
import 'package:kenali_app/screens/home_screen.dart';
import 'package:kenali_app/screens/profile_page.dart';
import 'package:kenali_app/screens/prediksi_hasil.dart';
import 'package:kenali_app/screens/detail_prediksi.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
        '/profile': (context) => const ProfilePage(),
        '/prediksi_hasil': (context) => const detail_transaksi(),
      },
    );
  }
}
