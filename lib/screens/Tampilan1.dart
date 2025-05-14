import 'package:flutter/material.dart';

class Tampilan1 extends StatelessWidget {
  const Tampilan1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: Color(0xFFB1F2BC),
        image: DecorationImage(
          image: AssetImage("assets/images/background1.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Container(
          width: 320, // Perbesar ukuran logo
          height: 320,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/logo_kenali2.png"),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}