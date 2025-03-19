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
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDDF5FF), // Warna biru muda
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Logo "F" bentuk abstrak
            CustomPaint(
              size: const Size(80, 100),
              painter: FLogoPainter(),
            ),
            const SizedBox(height: 16),
            // Teks "Finomali"
            const Text(
              'Finomali',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Bagian atas (biru muda)
    paint.color = const Color(0xFF6BC6E2);
    final path1 = Path()
      ..moveTo(size.width * 0.25, size.height * 0.2)
      ..quadraticBezierTo(size.width * 0.8, 0, size.width * 0.75, size.height * 0.2)
      ..quadraticBezierTo(size.width * 0.7, size.height * 0.4, size.width * 0.25, size.height * 0.4)
      ..close();
    canvas.drawPath(path1, paint);

    // Bagian tengah (biru sedang)
    paint.color = const Color.fromARGB(255, 197, 29, 29);
    final path2 = Path()
      ..moveTo(size.width * 0.25, size.height * 0.4)
      ..quadraticBezierTo(size.width * 0.8, size.height * 0.3, size.width * 0.75, size.height * 0.5)
      ..quadraticBezierTo(size.width * 0.7, size.height * 0.65, size.width * 0.25, size.height * 0.65)
      ..close();
    canvas.drawPath(path2, paint);

    // Bagian bawah (biru tua)
    paint.color = const Color(0xFF060C4F);
    final path3 = Path()
      ..moveTo(size.width * 0.25, size.height * 0.65)
      ..quadraticBezierTo(size.width * 0.5, size.height * 0.85, size.width * 0.4, size.height)
      ..quadraticBezierTo(size.width * 0.1, size.height * 0.85, size.width * 0.25, size.height * 0.65)
      ..close();
    canvas.drawPath(path3, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
