import 'package:flutter/material.dart';
import 'package:interwork_app/widgets/main_layout.dart';
import '../mock/vagas.dart';
import '../mock/candidatos.dart';
import '../mock/likes_candidatos.dart';
import '../mock/likes_recrutadores.dart';

class SwipeInteressesScreen extends StatefulWidget {
  final bool isCandidato;

  const SwipeInteressesScreen({Key? key, required this.isCandidato})
    : super(key: key);

  @override
  State<SwipeInteressesScreen> createState() => _SwipeInteressesScreenState();
}

class _SwipeInteressesScreenState extends State<SwipeInteressesScreen> {
  List<Map<String, String>> interesses = [];

  @override
  void initState() {
    super.initState();

    final todasAsOpcoes = widget.isCandidato ? vagasMock : candidatosMock;
    final likesRecebidos =
        widget.isCandidato
            ? likesRecebidosCandidatos
            : likesRecebidosRecrutadores;

    // Apenas perfis que curtiram o usuário atual
    interesses =
        todasAsOpcoes
            .where((item) => likesRecebidos.contains(item['id']))
            .toList();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavLayout(
      currentIndex: 1,
      isCandidato: widget.isCandidato,
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
              const SizedBox(height: 16),
              Text(
                widget.isCandidato
                    ? 'Vagas que curtiram você'
                    : 'Candidatos interessados',
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child:
                    interesses.isEmpty
                        ? const Center(
                          child: Text(
                            'Sem interesses no momento.',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white70,
                            ),
                          ),
                        )
                        : ListView.separated(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          itemCount: interesses.length,
                          separatorBuilder:
                              (_, __) => const SizedBox(height: 16),
                          itemBuilder: (context, index) {
                            return _buildCard(interesses[index]);
                          },
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(Map<String, String> item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(item['foto'] ?? ''),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['nome'] ?? item['titulo'] ?? '',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.business_center,
                          size: 16,
                          color: Colors.white70,
                        ),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            item['setor'] ?? '',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            item['descricao'] ?? '',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
