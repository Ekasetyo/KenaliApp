import 'package:flutter/material.dart';
import 'auth_data.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isPasswordHidden = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordHidden = !_isPasswordHidden;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _onSignUp() {
  final email = emailController.text.trim();
  final username = usernameController.text.trim();
  final password = passwordController.text.trim();

  if (email.isEmpty || username.isEmpty || password.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Semua kolom harus diisi')),
    );
    return;
  }

  if (!email.endsWith('@gmail.com')) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Email harus menggunakan domain @gmail.com')),
    );
    return;
  }

  if (username.length < 6 || !_isUsernameValid(username)) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Username minimal 6 karakter dan harus kombinasi huruf dan angka')),
    );
    return;
  }

  if (password.length < 8 || !_isPasswordValid(password)) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Password minimal 8 karakter dan harus mengandung huruf serta angka')),
    );
    return;
  }

  // ✅ Simpan email, username, password
  registeredEmail = email;
  registeredUsername = username;
  registeredPassword = password;

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Akun berhasil dibuat, silakan login')),
  );

  Navigator.pushReplacementNamed(context, '/login');
}

  bool _isUsernameValid(String username) {
    final hasLetter = username.contains(RegExp(r'[A-Za-z]'));
    final hasNumber = username.contains(RegExp(r'[0-9]'));
    return hasLetter && hasNumber;
  }

  bool _isPasswordValid(String password) {
    final hasLetter = password.contains(RegExp(r'[A-Za-z]'));
    final hasNumber = password.contains(RegExp(r'[0-9]'));
    return hasLetter && hasNumber;
  }

  Widget _buildTextField({
    required String hint,
    required TextEditingController controller,
    bool isPassword = false,
  }) {
    return Container(
      width: 295,
      height: 48,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F7F8),
        borderRadius: BorderRadius.circular(100),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword ? _isPasswordHidden : false,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          hintText: hint,
          hintStyle: const TextStyle(
            color: Color(0xFF2C999E),
            fontSize: 14,
            fontFamily: 'Noto Sans Thai UI',
          ),
          border: InputBorder.none,
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    _isPasswordHidden ? Icons.visibility_off : Icons.visibility,
                    size: 20,
                    color: Colors.grey,
                  ),
                  onPressed: _togglePasswordVisibility,
                )
              : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB1F2BC),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 260,
                decoration: const BoxDecoration(
                  color: Color(0xFF67DCA8),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(80),
                    bottomRight: Radius.circular(80),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 100),
                    const Text(
                      'Selamat Datang',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Sebuah Aplikasi Yang Dibuat Untuk Memprediksi\nSeseorang Itu Memiliki Gejala Penyakit Stroke Atau Tidak',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 100),
                    const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontFamily: 'Istok Web',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 30),
                    _buildTextField(
                      hint: 'Email',
                      controller: emailController,
                    ),
                    _buildTextField(
                      hint: 'Username',
                      controller: usernameController,
                    ),
                    _buildTextField(
                      hint: 'Password',
                      controller: passwordController,
                      isPassword: true,
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: _onSignUp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Color(0xFF67DCA8), width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 14),
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Color(0xFF67DCA8),
                          fontSize: 24,
                          fontFamily: 'Noto Sans Thai UI',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account?',
                          style: TextStyle(
                            color: Color(0xFF2C999E),
                            fontSize: 12,
                            fontFamily: 'Noto Sans Thai UI',
                          ),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(context, '/login');
                          },
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              color: Color(0xFF67DCA8),
                              fontSize: 12,
                              fontFamily: 'Noto Sans Thai UI',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'OR',
                      style: TextStyle(
                        color: Color(0xFF67DCA8),
                        fontSize: 12,
                        fontFamily: 'Noto Sans Thai UI',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(4, (index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          width: 29,
                          height: 29,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage('https://placehold.co/29x29'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
