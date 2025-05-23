import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  runApp(const RiwayatPrediksiApp());
}

class RiwayatPrediksiApp extends StatelessWidget {
  const RiwayatPrediksiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RiwayatPrediksi(),
    );
  }
}

class RiwayatPrediksi extends StatefulWidget {
  const RiwayatPrediksi({super.key});

  @override
  State<RiwayatPrediksi> createState() => _RiwayatPrediksiState();
}

class _RiwayatPrediksiState extends State<RiwayatPrediksi> {
  late String currentTime;
  late String currentDate;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    _updateDateTime();
    timer = Timer.periodic(const Duration(seconds: 1), (_) => _updateDateTime());
  }

  void _updateDateTime() {
    final now = DateTime.now();
    final timeFormat = DateFormat('HH:mm');
    final dateFormat = DateFormat('EEEE, d MMMM yyyy', 'id_ID');
    setState(() {
      currentTime = timeFormat.format(now);
      currentDate = dateFormat.format(now);
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void _onNavTapped(int index) {
    switch (index) {
      case 1:
        Navigator.pushNamed(context, '/home');
        break;
      case 2:
        Navigator.pushNamed(context, '/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF67DCA8),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            HeaderSection(currentTime: currentTime, currentDate: currentDate),
            const InfoBox(),
            const RiwayatListBox(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF64D2A3),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: 1,
        onTap: _onNavTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profil'),
        ],
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  final String currentTime;
  final String currentDate;

  const HeaderSection({
    super.key,
    required this.currentTime,
    required this.currentDate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Colors.white,
            radius: 20,
            child: Icon(Icons.person, color: Colors.grey),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Selamat Datang,\nMoch. Rizki Romadhoni',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                currentTime,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              Text(
                currentDate,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class InfoBox extends StatelessWidget {
  const InfoBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F7F8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text(
        'Prediksi Dibuat : 4',
        style: TextStyle(
          color: Colors.black,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class RiwayatListBox extends StatelessWidget {
  const RiwayatListBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Riwayat Prediksi',
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          ListView.builder(
            itemCount: 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF67DCA8),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Prediksi ${index + 1}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Text(
                          'klik untuk melihat detail',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 6,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        print('Detail untuk item $index');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF67DCA8),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        textStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 2,
                      ),
                      child: const Text('Detail'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
