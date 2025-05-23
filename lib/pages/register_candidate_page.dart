import 'package:flutter/material.dart';

class RegisterCandidatePage extends StatefulWidget {
  final String name;
  final String email;
  final String password;

  const RegisterCandidatePage({
    super.key,
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  State<RegisterCandidatePage> createState() => _RegisterCandidatePageState();
}

class _RegisterCandidatePageState extends State<RegisterCandidatePage> {
  final _formKey = GlobalKey<FormState>();

  final _cpfController = TextEditingController();
  DateTime? _birthDate;
  final _phoneController = TextEditingController();
  String? _gender;
  final _jobTitleController = TextEditingController();
  final _locationController = TextEditingController();
  final _profileDescriptionController = TextEditingController();

  final List<String> _genders = ['Masculino', 'Feminino', 'Outro'];

  Future<void> _selectBirthDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _birthDate ?? DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (picked != null) {
      setState(() {
        _birthDate = picked;
      });
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

  void _submit() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cadastro enviado com sucesso!')),
      );
      // Pode adicionar ação adicional aqui
    }
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Olá, ${widget.name}',
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Complete seu cadastro com as informações abaixo',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),

                    // CPF
                    TextFormField(
                      controller: _cpfController,
                      decoration: _buildInputDecoration('CPF *'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Campo obrigatório';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Data de nascimento
                    GestureDetector(
                      onTap: () => _selectBirthDate(context),
                      child: AbsorbPointer(
                        child: TextFormField(
                          decoration: _buildInputDecoration('Data de nascimento *').copyWith(
                            hintText: _birthDate == null
                                ? 'Selecione a data'
                                : '${_birthDate!.day}/${_birthDate!.month}/${_birthDate!.year}',
                          ),
                          validator: (value) {
                            if (_birthDate == null) return 'Campo obrigatório';
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Telefone
                    TextFormField(
                      controller: _phoneController,
                      decoration: _buildInputDecoration('Telefone *'),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Campo obrigatório';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Gênero
                    DropdownButtonFormField<String>(
                      value: _gender,
                      decoration: _buildInputDecoration('Gênero *'),
                      items: _genders
                          .map((gender) => DropdownMenuItem(
                                value: gender,
                                child: Text(gender),
                              ))
                          .toList(),
                      onChanged: (value) => setState(() => _gender = value),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Campo obrigatório';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Cargo que procura
                    TextFormField(
                      controller: _jobTitleController,
                      decoration: _buildInputDecoration('Cargo que procura *'),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Campo obrigatório';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Localização
                    TextFormField(
                      controller: _locationController,
                      decoration: _buildInputDecoration('Localização *'),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Campo obrigatório';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Breve descrição de perfil
                    TextFormField(
                      controller: _profileDescriptionController,
                      decoration: _buildInputDecoration('Breve descrição de perfil *'),
                      maxLines: 5,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Campo obrigatório';
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submit,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF3943FF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'Enviar Cadastro',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
