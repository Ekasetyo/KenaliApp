import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailOrUsernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _login() {
    // Login tanpa validasi apa pun, langsung lanjut ke menu utama
    Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
  }

  @override
  void dispose() {
    emailOrUsernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Ubah jadi transparan
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/background2.png",
              fit: BoxFit.cover,
            ),
          ),
          GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Container(
                  width: 330,
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Selamat Datang',
                        style: TextStyle(
                          color: Color(0xFF2A9A9E),
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Sebuah Aplikasi Untuk Memprediksi Gejala Penyakit Stroke',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 12,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      _buildCenteredTextField(
                        controller: emailOrUsernameController,
                        hint: 'Email atau Username',
                      ),
                      const SizedBox(height: 20),
                      _buildCenteredTextField(
                        controller: passwordController,
                        hint: 'Password',
                        obscure: _obscurePassword,
                        showVisibilityToggle: true,
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: 260,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: _login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF66DBA7),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Noto Sans Thai UI',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCenteredTextField({
    required TextEditingController controller,
    required String hint,
    bool obscure = false,
    bool showVisibilityToggle = false,
  }) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 260,
          decoration: BoxDecoration(
            color: const Color(0xFFF9F7F8),
            borderRadius: BorderRadius.circular(100),
          ),
          child: TextField(
            controller: controller,
            obscureText: obscure,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),
        if (showVisibilityToggle)
          Positioned(
            right: 20,
            child: GestureDetector(
              onTap: _togglePasswordVisibility,
              child: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                size: 20,
                color: Colors.grey,
              ),
            ),
          ),
      ],
    );
  }
}
