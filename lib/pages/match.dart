import 'package:flutter/material.dart';

void showMatchPopup({
  required BuildContext context,
  required String nomeOutroUsuario,
  required String imageUrlEmpresa,
  required String imageUrlPessoa,
  required VoidCallback onChatPressed,
}) {
  showDialog(
    context: context,
    barrierDismissible: false, // força interação com os botões
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            gradient: const LinearGradient(
              colors: [Color(0xFFB931FC), Color(0xFF6C63FF)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.handshake, size: 48, color: Colors.white),
              const SizedBox(height: 16),
              const Text(
                "It’s a Deal!",
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Tome iniciativa, envie a mensagem primeiro!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
              const SizedBox(height: 24),
              Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(imageUrlEmpresa),
                    radius: 36,
                    backgroundColor: Colors.white,
                  ),
                  Positioned(
                    right: -8,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(imageUrlPessoa),
                      radius: 32,
                      backgroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 36),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.indigo,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  onChatPressed();
                },
                child: const Text("Enviar mensagem"),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "VOLTAR A NAVEGAÇÃO",
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
