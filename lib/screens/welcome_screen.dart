import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/register': (context) => const Placeholder(), // Ganti dengan screen yang sesuai
        '/login': (context) => const Placeholder(), // Ganti dengan screen yang sesuai
      },
      home: const WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFB1F2BC),
      body: Column(
        children: [
          // Shape atas + logo
          Container(
            width: double.infinity,
            height: screenHeight * 0.4,
            decoration: const BoxDecoration(
              color: Color(0xFF67DCA8),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(80),
                bottomRight: Radius.circular(80),
              ),
            ),
            child: Center(
              child: Image.asset(
                'assets/images/logo_kenali.png',
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),
            ),
          ),

          const SizedBox(height: 40),

          const Text(
            'Selamat Datang',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'Montserrat',
            ),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              'Sebuah Aplikasi Yang Dibuat Untuk Memprediksi '
              'Seseorang Itu Memiliki Gejala Penyakit Stroke Atau Tidak',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
          const Spacer(),

          // Tombol Register & Sign In
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: Container(
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Color(0xFF66DBA7),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Container(
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Color(0xFFDFFDFF),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF66DBA7),
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
