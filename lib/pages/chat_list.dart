import 'package:flutter/material.dart';
import 'package:interwork_app/widgets/bottom_nav_layout.dart';
import 'chat_screen.dart';

class ConversationsListScreen extends StatelessWidget {
  final List<Map<String, dynamic>> conversations = [
    {
      'nome': 'João Silva',
      'foto': 'https://via.placeholder.com/50',
      'ultimaMensagem': 'Olá! Como vai?',
      'data': 'Hoje, 14:30',
      'novas': true,
    },
    {
      'nome': 'Maria Souza',
      'foto': 'https://via.placeholder.com/50',
      'ultimaMensagem': 'Enviado o currículo!',
      'data': 'Ontem, 18:45',
      'novas': false,
    },
  ];

  ConversationsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Pegamos a flag isCandidato passada por rota anterior
    final bool isCandidato =
        ModalRoute.of(context)?.settings.arguments as bool? ?? true;

    return BottomNavLayout(
      currentIndex: 2, // posição do ícone de chat
      isCandidato: isCandidato,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFC73AFF), Color(0xFF3943FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'Conversas',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: conversations.length,
                  itemBuilder: (context, index) {
                    final conversa = conversations[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(conversa['foto']),
                      ),
                      title: Text(
                        conversa['nome'],
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        conversa['ultimaMensagem'],
                        style: const TextStyle(color: Colors.white70),
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            conversa['data'],
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white60,
                            ),
                          ),
                          if (conversa['novas'])
                            const Icon(
                              Icons.circle,
                              color: Colors.red,
                              size: 10,
                            ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => ChatScreen(
                                  nome: conversa['nome'],
                                  foto: conversa['foto'],
                                ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
