import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class MenuDeteksi extends StatefulWidget {
  const MenuDeteksi({super.key});

  @override
  State<MenuDeteksi> createState() => _MenuDeteksiState();
}

class _MenuDeteksiState extends State<MenuDeteksi> {
  final TextEditingController usiaController = TextEditingController();
  final TextEditingController bmiController = TextEditingController();
  final TextEditingController gulaDarahController = TextEditingController();

  String genderValue = '';
  String hipertensiValue = '';
  String jantungValue = '';
  String menikahValue = '';
  String pekerjaanValue = '';
  String areaValue = '';
  String rokokValue = '';

  String predictionResult = '';
  bool isLoading = false;

  Future<void> _confirmDetection() async {
    final shouldProceed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi'),
        content: const Text('Apakah data sudah sesuai untuk dilakukan deteksi?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Tidak')),
          TextButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('Ya')),
        ],
      ),
    );

    if (shouldProceed == true) {
      _performDetection();
    }
  }

  Future<void> _performDetection() async {
    setState(() {
      isLoading = true;
      predictionResult = '';
    });

    final prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString('user_data');
    String? userId = jsonDecode(userDataString ?? '{}')['id'];

    try {
      final response = await http.post(
        Uri.parse('http://localhost:5000/api/predict'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'user_id': userId,
          'sex': genderValue == 'laki-laki' ? 1 : 0,
          'age': int.parse(usiaController.text),
          'hypertension': hipertensiValue == 'iya' ? 1 : 0,
          'heart_disease': jantungValue == 'iya' ? 1 : 0,
          'ever_married': menikahValue == 'iya' ? 1 : 0,
          'work_type': pekerjaanValue == 'tidak bekerja'
              ? 0
              : pekerjaanValue == 'anak-anak'
                  ? 1
                  : pekerjaanValue == 'PNS'
                      ? 2
                      : pekerjaanValue == 'wiraswasta'
                          ? 3
                          : 4,
          'Residence_type': areaValue == 'perkotaan' ? 1 : 0,
          'avg_glucose_level': int.parse(gulaDarahController.text),
          'bmi': int.parse(bmiController.text),
          'smoking_status': rokokValue == 'iya' ? 1 : 0,
        }),
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        setState(() {
          predictionResult = result['prediction'];
        });
      } else {
        setState(() {
          predictionResult = 'Terjadi kesalahan: ${response.body}';
        });
      }
    } catch (e) {
      setState(() {
        predictionResult = 'Terjadi kesalahan jaringan: $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value.isEmpty ? null : value,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: onChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Text('Deteksi Dini'),
        backgroundColor: const Color(0xFF6DE39B),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(), // kembali ke halaman sebelumnya
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              buildDropdownField(
                label: 'Jenis Kelamin',
                value: genderValue,
                items: ['perempuan', 'laki-laki'],
                onChanged: (val) => setState(() => genderValue = val ?? ''),
              ),
              const SizedBox(height: 12),

              TextField(
                controller: usiaController,
                decoration: const InputDecoration(
                  labelText: 'Usia',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),

              buildDropdownField(
                label: 'Hipertensi',
                value: hipertensiValue,
                items: ['tidak', 'iya'],
                onChanged: (val) => setState(() => hipertensiValue = val ?? ''),
              ),
              const SizedBox(height: 12),

              TextField(
                controller: gulaDarahController,
                decoration: const InputDecoration(
                  labelText: 'Kadar Gula Darah',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),

              buildDropdownField(
                label: 'Riwayat Penyakit Jantung',
                value: jantungValue,
                items: ['tidak', 'iya'],
                onChanged: (val) => setState(() => jantungValue = val ?? ''),
              ),
              const SizedBox(height: 12),

              TextField(
                controller: bmiController,
                decoration: const InputDecoration(
                  labelText: 'BMI',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),

              buildDropdownField(
                label: 'Status Menikah',
                value: menikahValue,
                items: ['tidak', 'iya'],
                onChanged: (val) => setState(() => menikahValue = val ?? ''),
              ),
              const SizedBox(height: 12),

              buildDropdownField(
                label: 'Pekerjaan',
                value: pekerjaanValue,
                items: ['tidak bekerja', 'anak-anak', 'PNS', 'wiraswasta', 'swasta'],
                onChanged: (val) => setState(() => pekerjaanValue = val ?? ''),
              ),
              const SizedBox(height: 12),

              buildDropdownField(
                label: 'Area Tempat Tinggal',
                value: areaValue,
                items: ['pedesaan', 'perkotaan'],
                onChanged: (val) => setState(() => areaValue = val ?? ''),
              ),
              const SizedBox(height: 12),

              buildDropdownField(
                label: 'Perokok',
                value: rokokValue,
                items: ['tidak', 'iya'],
                onChanged: (val) => setState(() => rokokValue = val ?? ''),
              ),
              const SizedBox(height: 24),

              Center(
                child: ElevatedButton(
                  onPressed: _confirmDetection,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6DE39B),
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                  ),
                  child: const Text('Deteksi', style: TextStyle(fontSize: 18)),
                ),
              ),
              const SizedBox(height: 24),

              if (isLoading)
                const Center(child: CircularProgressIndicator())
              else if (predictionResult.isNotEmpty)
                Center(
                  child: Text(
                    'Hasil Deteksi: $predictionResult',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
