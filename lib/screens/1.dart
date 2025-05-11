import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stroke Prediction App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Inter',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/detail_prediksi': (context) => const DetailPrediksiScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
      localizationsDelegates: const [ //Tambahkan delegate ini
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [ //Tambahkan locale yang disupport
        Locale('id', 'ID'), //Indonesia
        Locale('en', 'US'), //Inggris
      ],
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _username = 'Moch. Rizki Romadhoni';
  final List<String> _predictionTitles = [
    'Prediksi 1',
    'Prediksi 2',
    'Prediksi 3',
    'Prediksi 4',
  ];

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? 'Moch. Rizki Romadhoni';
    });
  }

  void _navigateToPredictionDetail(int index) {
    Navigator.pushNamed(
      context,
      '/detail_prediksi',
      arguments: {'predictionNumber': index + 1},
    );
  }

  Widget _buildRealTimeClock() {
    return StreamBuilder(
      stream: Stream.periodic(const Duration(seconds: 1)),
      builder: (context, snapshot) {
        final now = DateTime.now();
        final time = DateFormat.Hm().format(now);
        final date = DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(now); // 'yyyy' ditambahkan
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              time,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              date,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPredictionButton(int index, String title) {
    return GestureDetector(
      onTap: () => _navigateToPredictionDetail(index),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFFF9F7F8),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _onNavTapped(int index) {
    if (index == 1) return;
    if (index == 0) {
      Navigator.pushNamed(context, '/dashboard');
    } else if (index == 2) {
      Navigator.pushNamed(context, '/profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F7EF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/profile'),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Selamat Datang,',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          _username,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildRealTimeClock(),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: _predictionTitles.asMap().entries.map((entry) {
                    final int index = entry.key;
                    final String title = entry.value;
                    return _buildPredictionButton(index, title);
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF67DCA8),
        selectedItemColor: Colors.black87,
        unselectedItemColor: Colors.black54,
        currentIndex: 1,
        onTap: _onNavTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.apps_rounded), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profil'),
        ],
      ),
    );
  }
}

// Contoh halaman Detail Prediksi (detail_prediksi.dart)
class DetailPrediksiScreen extends StatelessWidget {
  const DetailPrediksiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final int predictionNumber = args?['predictionNumber'] ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: Text('Prediksi $predictionNumber'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            'Ini adalah halaman detail untuk Prediksi $predictionNumber.  Anda dapat menampilkan grafik atau informasi lebih lanjut di sini.',
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

// Contoh Halaman Profil (profile.dart)
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            'Ini adalah halaman profil pengguna. Anda dapat menampilkan informasi profil pengguna di sini.',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

