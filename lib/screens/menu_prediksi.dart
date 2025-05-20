import 'package:flutter/material.dart';
import 'editable_dropdown_field.dart'; // sesuaikan lokasi file jika berbeda
import 'home_screen.dart'; // pastikan file home_screen.dart ada dan berisi HomeScreen widget

void main() {
  runApp(MenuPrediksiPage());
}

class MenuPrediksiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Prediksi Stroke',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MenuPrediksi(), // Awal aplikasi diarahkan ke MenuPrediksi
    );
  }
}

class MenuPrediksi extends StatefulWidget {
  const MenuPrediksi({super.key});

  @override
  State<MenuPrediksi> createState() => _MenuPrediksiState();
}

// Widget untuk input manual angka saja (textfield)
class ManualInputField extends StatelessWidget {
  final String label;
  final String value;
  final bool isNumber;
  final void Function(String) onChanged;

  const ManualInputField({
    super.key,
    required this.label,
    required this.value,
    this.isNumber = false,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      controller: TextEditingController(text: value),
      onChanged: onChanged,
    );
  }
}

// Widget untuk dropdown tanpa input manual
class DropdownOnlyField extends StatelessWidget {
  final String label;
  final String value;
  final List<String> options;
  final void Function(String?) onChanged;

  const DropdownOnlyField({
    super.key,
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: value.isEmpty ? null : value,
          hint: Text('Pilih $label'),
          items: options.map((opt) {
            return DropdownMenuItem(
              value: opt,
              child: Text(opt),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
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

    print('Usia: $usiaValue');
    print('BMI: $bmiValue');
    print('Kadar gula darah: $gulaValue');
    print('Hipertensi: $hipertensiValue');
    print('Riwayat jantung: $jantungValue');
    print('Status menikah: $menikahValue');
    print('Pekerjaan: $pekerjaanValue');
    print('Area tinggal: $areaValue');
    print('Perokok: $rokokValue');
    print('Jenis kelamin: $genderValue');

    _showSnackBar('Data valid, proses prediksi dapat dilakukan.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB2F7C1),
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
            fontWeight: FontWeight.bold, // Tambahkan ini agar bold
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            padding: const EdgeInsets.only(top: 40),  // <-- padding atas tambahan supaya tidak ketutup
            children: [
              DropdownOnlyField(
                label: 'Jenis kelamin',
                value: genderValue,
                options: ['perempuan', 'laki-laki'],
                onChanged: (val) => setState(() => genderValue = val ?? ''),
              ),
              const SizedBox(height: 12),

              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Usia",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                controller: usiaController,
              ),
              const SizedBox(height: 12),

              DropdownOnlyField(
                label: 'Hipertensi',
                value: hipertensiValue,
                options: ['tidak', 'iya'],
                onChanged: (val) => setState(() => hipertensiValue = val ?? ''),
              ),
              const SizedBox(height: 12),

              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Kadar gula darah",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                controller: gulaDarahController,
              ),
              const SizedBox(height: 12),

              DropdownOnlyField(
                label: 'Riwayat Penyakit jantung',
                value: jantungValue,
                options: ['tidak', 'iya'],
                onChanged: (val) => setState(() => jantungValue = val ?? ''),
              ),
              const SizedBox(height: 12),

              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "BMI",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                controller: bmiController,
              ),
              const SizedBox(height: 12),

              DropdownOnlyField(
                label: 'Status menikah',
                value: menikahValue,
                options: ['tidak', 'iya'],
                onChanged: (val) => setState(() => menikahValue = val ?? ''),
              ),
              const SizedBox(height: 12),

              DropdownOnlyField(
                label: 'Pekerjaan',
                value: pekerjaanValue,
                options: ['tidak bekerja', 'anak-anak', 'PNS', 'wiraswasta'],
                onChanged: (val) => setState(() => pekerjaanValue = val ?? ''),
              ),
              const SizedBox(height: 12),

              DropdownOnlyField(
                label: 'Area tempat tinggal',
                value: areaValue,
                options: ['pedesaan', 'perkotaan'],
                onChanged: (val) => setState(() => areaValue = val ?? ''),
              ),
              const SizedBox(height: 12),

              DropdownOnlyField(
                label: 'Perokok',
                value: rokokValue,
                options: ['tidak', 'iya'],
                onChanged: (val) => setState(() => rokokValue = val ?? ''),
              ),
              const SizedBox(height: 24),

              Center(
                child: ElevatedButton(
                  onPressed: _validateAndPredict,
                  child: const Text(
                    'Prediksi',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6DE39D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 200, vertical: 25),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
