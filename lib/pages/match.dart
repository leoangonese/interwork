import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void showMatchPopup({
  required BuildContext context,
  required String nomeOutroUsuario,
  required String imageUrlEmpresa,
  required String imageUrlPessoa,
  required VoidCallback onChatPressed,
}) {
  showGeneralDialog(
    context: context,
    barrierDismissible:
        false, // Impede que o usuário feche o popup tocando fora dele
    barrierLabel: "Match",
    pageBuilder: (_, __, ___) {
      return Scaffold(
        backgroundColor:
            Colors
                .transparent, // Fundo transparente para manter o gradiente visível
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            // Gradiente de fundo, conforme a imagem
            gradient: LinearGradient(
              colors: [Color(0xFFB931FC), Color(0xFF6C63FF)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Ícone de aperto de mãos
              SvgPicture.asset(
                'images/icons/match.svg',
                width: 48, // mesmo tamanho que o Icon tinha
                height: 48,
                color: Colors.white, // aplica cor, se o SVG for monocromático
                semanticsLabel: 'Mãos apertando',
              ),
              // Título principal
              const Text(
                "It’s a Deal!",
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              // Subtítulo com duas linhas, centralizado
              const Text(
                "Tome iniciativa, envie a\nmensagem primeiro!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 40),

              // Avatares empilhados (empresa e pessoa)
              Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  // Imagem da empresa
                  CircleAvatar(
                    backgroundImage: NetworkImage(imageUrlEmpresa),
                    radius: 50,
                    backgroundColor: Colors.white,
                  ),
                  // Imagem da pessoa posicionada por cima
                  Positioned(
                    right: -40, // deslocamento lateral
                    bottom: -10, // leve sobreposição inferior
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(imageUrlPessoa),
                      radius: 36,
                      backgroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 60),

              // Botão principal: Enviar mensagem
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Color(0xFF4A3AFF), // texto em roxo forte
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      40,
                    ), // bordas arredondadas
                  ),
                  elevation: 6, // sombra
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context); // fecha o popup
                  onChatPressed(); // executa a ação desejada (abrir chat)
                },
                child: const Text("Enviar mensagem"),
              ),
              const SizedBox(height: 16),

              // Botão secundário: voltar
              TextButton(
                onPressed: () => Navigator.pop(context), // apenas fecha o popup
                child: const Text(
                  "VOLTAR A NAVEGAÇÃO",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    letterSpacing: 0.5, // leve espaçamento entre letras
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
