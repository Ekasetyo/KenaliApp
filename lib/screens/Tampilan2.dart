import 'package:flutter/material.dart';

class Tampilan2 extends StatelessWidget {
  const Tampilan2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: Color(0xFFB1F2BC),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/background1.png",
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: const Alignment(0, -0.1),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Selamat Datang Di Kenali!',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF00722D),
                  fontSize: 50,
                  fontFamily: 'Poppins', // Ganti ke Poppins
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, 0.3),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                'Kenali membantu Anda mengenali dan memahami risiko stroke secara mudah dan cepat. Dengan aplikasi ini, Anda dapat melakukan skrining mandiri untuk mengetahui apakah Anda berisiko tinggi, sedang, atau sehat dari penyakit stroke. Lindungi kesehatan Anda sejak dini!',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF00722D),
                  fontSize: 12,
                  fontFamily: 'Poppins', // Ganti ke Poppins
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
