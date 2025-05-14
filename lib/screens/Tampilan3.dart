import 'package:flutter/material.dart';

class Tampilan3 extends StatelessWidget {
  const Tampilan3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(color: Color(0xFFB1F2BC)),
      child: Stack(
        children: [
          Positioned(
            left: -13,
            top: -8,
            child: Container(
              width: 544,
              height: 816,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background2.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, -0.1), // sedikit di atas tengah
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Tentang Stroke',
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
            alignment: const Alignment(0, 0.2), // sedikit di bawah judul
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                'Stroke merupakan salah satu penyebab utama kematian dan kecacatan di dunia. Stroke terjadi akibat adanya gangguan aliran darah ke otak yang menyebabkan kerusakan permanen jika tidak segera ditangani.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF00722D),
                  fontSize: 12,
                  fontFamily: 'Montserrat',
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
