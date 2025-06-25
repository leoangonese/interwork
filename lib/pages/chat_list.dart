// chat_list.dart
import 'package:flutter/material.dart';
import 'package:interwork_app/widgets/main_layout.dart';
import 'package:interwork_app/mock/vagas.dart';
import 'package:interwork_app/mock/candidatos.dart';
import 'package:interwork_app/mock/likes_candidatos.dart';
import 'package:interwork_app/mock/likes_recrutadores.dart';
import 'chat_screen.dart';

class ConversationsListScreen extends StatelessWidget {
  final bool isCandidato;

  const ConversationsListScreen({Key? key, this.isCandidato = true})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> allMatches =
        isCandidato
            ? vagasMock.where((vaga) {
              final id = vaga['id'];
              return id != null &&
                  likesRecebidosCandidatos.contains(
                    id,
                  ) && // vaga curtiu candidato
                  likesFeitosPeloCandidato.contains(
                    id,
                  ); // candidato curtiu vaga
            }).toList()
            : candidatosMock.where((candidato) {
              final id = candidato['id'];
              return id != null &&
                  likesRecebidosRecrutadores.contains(
                    id,
                  ) && // candidato curtiu vaga
                  likesFeitosPeloRecrutador.contains(
                    id,
                  ); // recrutador curtiu candidato
            }).toList();

    return BottomNavLayout(
      currentIndex: 2,
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
          child: Padding(
            padding: const EdgeInsets.only(top: 90), // evita sobrepor a navbar
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Mensagens',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: ListView.separated(
                    itemCount: allMatches.length,
                    separatorBuilder:
                        (_, __) => const Divider(
                          color: Colors.white24,
                          indent: 80,
                          endIndent: 16,
                        ),
                    itemBuilder: (context, index) {
                      final match = allMatches[index];
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        leading: Stack(
                          children: [
                            CircleAvatar(
                              radius: 28,
                              backgroundImage: AssetImage(match['foto']!),
                            ),
                            if (index == 0)
                              const Positioned(
                                top: 0,
                                right: 0,
                                child: Icon(
                                  Icons.circle,
                                  color: Colors.red,
                                  size: 12,
                                ),
                              ),
                          ],
                        ),
                        title: Text(
                          match['nome'] ?? match['titulo'] ?? '',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        subtitle: Text(
                          index == 0
                              ? 'Não ta contratando...'
                              : 'Contratadon’t.',
                          style: const TextStyle(color: Colors.white70),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) => ChatScreen(
                                    nome:
                                        match['nome'] ?? match['titulo'] ?? '',
                                    foto: match['foto']!,
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
      ),
    );
  }
}

/*
import 'package:flutter/material.dart';
import 'package:interwork_app/widgets/main_layout.dart';
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
*/
