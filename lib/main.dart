import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

// Import semua layar yang digunakan
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/home_screen.dart';
import 'screens/profile_page.dart';
import 'screens/prediksi_hasil.dart';
import 'screens/detail_prediksi.dart'; // Pastikan class di file ini bernama DetailPrediksiScreen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi format tanggal lokal Indonesia
  await initializeDateFormatting('id_ID', null);

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
      initialRoute: '/home', // Rute awal aplikasi
      routes: {
        '/': (context) => const SplashScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/profile': (context) => const ProfilePage(),
        '/prediksi_hasil': (context) => const PrediksiHasil(),
        '/detail_prediksi': (context) => const DetailPrediksi(), // Pastikan nama class ini sesuai
      },
    );
  }
}
