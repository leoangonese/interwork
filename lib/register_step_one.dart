import 'package:flutter/material.dart';
import 'pages/register_candidate_page.dart';
import 'pages/register_recruiter_page.dart';

enum UserType { candidate, recruiter }

class RegisterStepOne extends StatefulWidget {
  const RegisterStepOne({super.key});

  @override
  State<RegisterStepOne> createState() => _RegisterStepOneState();
}

class _RegisterStepOneState extends State<RegisterStepOne> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  UserType _userType = UserType.candidate;

  void _goToNextStep() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final email = _emailController.text;
      final password = _passwordController.text;

      if (_userType == UserType.candidate) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RegisterCandidatePage(name: name, email: email, password: password),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RegisterRecruiterPage(name: name, email: email, password: password),
          ),
        );
      }
    }
  }

  InputDecoration _buildInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFC73AFF), Color(0xFF3943FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                        Image.asset(
              'assets/images/logo.png',
               width: 250,
               color: Colors.white,
            ),

                                        const SizedBox(height: 50),
                    const Text(
                      'Crie sua conta e faça novas conexões no interwork!',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: _nameController,
                      decoration: _buildInputDecoration('Nome completo*'),
                      validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _emailController,
                      decoration: _buildInputDecoration('Email*'),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Campo obrigatório';
                        final regex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
                        if (!regex.hasMatch(value)) return 'Email inválido';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      decoration: _buildInputDecoration('Senha*'),
                      obscureText: true,
                      validator: (value) => value!.length < 6 ? 'Mínimo 6 caracteres' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _confirmPasswordController,
                      decoration: _buildInputDecoration('Confirmar senha*'),
                      obscureText: true,
                      validator: (value) => value != _passwordController.text ? 'As senhas não coincidem' : null,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          RadioListTile<UserType>(
                            title: const Text('Sou Candidato'),
                            value: UserType.candidate,
                            groupValue: _userType,
                            onChanged: (value) => setState(() => _userType = value!),
                          ),
                          RadioListTile<UserType>(
                            title: const Text('Sou Recrutador'),
                            value: UserType.recruiter,
                            groupValue: _userType,
                            onChanged: (value) => setState(() => _userType = value!),
                          ),
                        ],
                      ),
                    ),
                                        const SizedBox(height: 30),

                                Container(
              height: 1,
              color: Colors.white,
              width: double.infinity,
            ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _goToNextStep,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'Próximo',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Color(0xFF3943FF)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
