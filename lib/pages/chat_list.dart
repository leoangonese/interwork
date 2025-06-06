import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Conversas')),
      body: ListView.builder(
        itemCount: conversations.length,
        itemBuilder: (context, index) {
          final conversa = conversations[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(conversa['foto']),
            ),
            title: Text(conversa['nome']),
            subtitle: Text(conversa['ultimaMensagem']),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(conversa['data'], style: TextStyle(fontSize: 12)),
                if (conversa['novas'])
                  const Icon(Icons.circle, color: Colors.red, size: 10),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChatScreen(nome: conversa['nome'], foto: conversa['foto']),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
