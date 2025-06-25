import 'package:flutter/material.dart';
import 'register_step_one.dart';
import './pages/swipe.dart';
import './mock/usuarios.dart'; // <-- importar os mockados

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  String? errorText;

  void _login() {
    final email = emailController.text.trim();
    final senha = senhaController.text;

    if (email.isEmpty || senha.isEmpty) {
      setState(() {
        errorText = 'Por favor, preencha todos os campos.';
      });
      return;
    }

    final user = mockUsers.firstWhere(
      (u) => u['email'] == email && u['senha'] == senha,
      orElse: () => {},
    );

    if (user.isNotEmpty) {
      final isCandidato = user['tipo'] == 'candidato';

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => SwipeProfileScreen(isCandidato: isCandidato),
        ),
      );
    } else {
      setState(() {
        errorText = 'Email ou senha inválidos.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFC73AFF), Color(0xFF3943FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 250,
              color: Colors.white,
            ),

            const SizedBox(height: 32),

            _buildInputField(label: 'Email: *', controller: emailController),

            const SizedBox(height: 16),

            _buildInputField(
              label: 'Senha: *',
              controller: senhaController,
              obscureText: true,
            ),

            const SizedBox(height: 16),

            if (errorText != null)
              Text(errorText!, style: const TextStyle(color: Colors.redAccent)),

            const SizedBox(height: 24),
            Container(height: 1, color: Colors.white, width: double.infinity),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: _login,
                child: const Text(
                  'Entrar',
                  style: TextStyle(
                    color: Color(0xFF3943FF),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterStepOne(),
                      ),
                    );
                  },
                  child: const Text(
                    'NÃO POSSUI CADASTRO?',
                    style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),
            const Text(
              'ESQUECEU A SENHA?',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }
}
