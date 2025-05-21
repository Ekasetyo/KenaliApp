import 'package:flutter/material.dart';
import 'editable_dropdown_field.dart';
import 'home_screen.dart';

void main() {
  runApp(MenuPrediksiPage());
}

class MenuPrediksiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Prediksi Stroke',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: MenuPrediksi(),
    );
  }
}

class MenuPrediksi extends StatefulWidget {
  const MenuPrediksi({super.key});

  @override
  State<MenuPrediksi> createState() => _MenuPrediksiState();
}

class _MenuPrediksiState extends State<MenuPrediksi> {
  final TextEditingController usiaController = TextEditingController();
  final TextEditingController bmiController = TextEditingController();
  final TextEditingController gulaDarahController = TextEditingController();

  String usiaValue = '';
  String bmiValue = '';
  String gulaValue = '';
  String hipertensiValue = '';
  String jantungValue = '';
  String menikahValue = '';
  String pekerjaanValue = '';
  String areaValue = '';
  String rokokValue = '';
  String genderValue = '';

  bool _isNumberValid(String val) {
    if (val.isEmpty) return false;
    final number = num.tryParse(val);
    return number != null;
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _validateAndPredict() {
    usiaValue = usiaController.text.trim();
    bmiValue = bmiController.text.trim();
    gulaValue = gulaDarahController.text.trim();

    if (usiaValue.isEmpty ||
        bmiValue.isEmpty ||
        gulaValue.isEmpty ||
        hipertensiValue.isEmpty ||
        jantungValue.isEmpty ||
        menikahValue.isEmpty ||
        pekerjaanValue.isEmpty ||
        areaValue.isEmpty ||
        rokokValue.isEmpty ||
        genderValue.isEmpty) {
      _showSnackBar('Mohon isi semua data terlebih dahulu!');
      return;
    }

    if (!_isNumberValid(usiaValue)) {
      _showSnackBar('Usia harus berupa angka yang valid!');
      return;
    }
    if (!_isNumberValid(bmiValue)) {
      _showSnackBar('BMI harus berupa angka yang valid!');
      return;
    }
    if (!_isNumberValid(gulaValue)) {
      _showSnackBar('Kadar gula darah harus berupa angka yang valid!');
      return;
    }

    _showSnackBar('Data valid, proses prediksi dapat dilakukan.');
  }

  Widget _customCardInput({required Widget child}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8FDF2),
      appBar: AppBar(
        backgroundColor: const Color(0xFF6DE39D),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
              (route) => false,
            );
          },
        ),
        title: const Text(
          'Prediksi Dini',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Lengkapi Data Anda',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              _customCardInput(
                child: DropdownOnlyField(
                  label: 'Jenis kelamin',
                  value: genderValue,
                  options: ['perempuan', 'laki-laki'],
                  onChanged: (val) =>
                      setState(() => genderValue = val ?? ''),
                ),
              ),
              _customCardInput(
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: usiaController,
                  decoration: const InputDecoration(
                    labelText: 'Usia',
                    border: InputBorder.none,
                  ),
                ),
              ),
              _customCardInput(
                child: DropdownOnlyField(
                  label: 'Hipertensi',
                  value: hipertensiValue,
                  options: ['tidak', 'iya'],
                  onChanged: (val) =>
                      setState(() => hipertensiValue = val ?? ''),
                ),
              ),
              _customCardInput(
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: gulaDarahController,
                  decoration: const InputDecoration(
                    labelText: 'Kadar gula darah',
                    border: InputBorder.none,
                  ),
                ),
              ),
              _customCardInput(
                child: DropdownOnlyField(
                  label: 'Riwayat Penyakit jantung',
                  value: jantungValue,
                  options: ['tidak', 'iya'],
                  onChanged: (val) =>
                      setState(() => jantungValue = val ?? ''),
                ),
              ),
              _customCardInput(
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: bmiController,
                  decoration: const InputDecoration(
                    labelText: 'BMI',
                    border: InputBorder.none,
                  ),
                ),
              ),
              _customCardInput(
                child: DropdownOnlyField(
                  label: 'Status menikah',
                  value: menikahValue,
                  options: ['tidak', 'iya'],
                  onChanged: (val) =>
                      setState(() => menikahValue = val ?? ''),
                ),
              ),
              _customCardInput(
                child: DropdownOnlyField(
                  label: 'Pekerjaan',
                  value: pekerjaanValue,
                  options: [
                    'tidak bekerja',
                    'anak-anak',
                    'PNS',
                    'wiraswasta'
                  ],
                  onChanged: (val) =>
                      setState(() => pekerjaanValue = val ?? ''),
                ),
              ),
              _customCardInput(
                child: DropdownOnlyField(
                  label: 'Area tempat tinggal',
                  value: areaValue,
                  options: ['pedesaan', 'perkotaan'],
                  onChanged: (val) =>
                      setState(() => areaValue = val ?? ''),
                ),
              ),
              _customCardInput(
                child: DropdownOnlyField(
                  label: 'Perokok',
                  value: rokokValue,
                  options: ['tidak', 'iya'],
                  onChanged: (val) =>
                      setState(() => rokokValue = val ?? ''),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: GestureDetector(
                  onTap: _validateAndPredict,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 80, vertical: 18),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF6DE39D), Color(0xFF48C78E)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.4),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const Text(
                      'Prediksi',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}