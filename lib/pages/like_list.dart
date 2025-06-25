import 'package:flutter/material.dart';
import 'package:interwork_app/widgets/bottom_nav_layout.dart';

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

    if (widget.isCandidato) {
      interesses = [
        {
          'nome': 'Empresa A',
          'setor': 'Tecnologia - SP',
          'descricao': 'Procuramos desenvolvedores Flutter.',
          'foto': 'https://randomuser.me/api/portraits/men/45.jpg',
        },
        {
          'nome': 'Empresa B',
          'setor': 'Marketing - RJ',
          'descricao': 'Vaga para analista de marketing.',
          'foto': 'https://randomuser.me/api/portraits/men/46.jpg',
        },
        {
          'nome': 'Empresa C',
          'setor': 'Finanças - RJ',
          'descricao': 'Vaga para analista financeiro.',
          'foto': 'https://randomuser.me/api/portraits/men/48.jpg',
        },
        {
          'nome': 'Empresa D',
          'setor': 'RH - SP',
          'descricao': 'Vaga para assistente de RH.',
          'foto': 'https://randomuser.me/api/portraits/women/45.jpg',
        },
      ];
    } else {
      interesses = [
        {
          'nome': 'Maria Silva',
          'setor': 'Designer - BH',
          'descricao': 'Profissional criativa e dedicada.',
          'foto': 'https://randomuser.me/api/portraits/women/44.jpg',
        },
        {
          'nome': 'Carlos Souza',
          'setor': 'Desenvolvedor - SP',
          'descricao': 'Especialista em mobile e web.',
          'foto': 'https://randomuser.me/api/portraits/men/47.jpg',
        },
        {
          'nome': 'Ana Pereira',
          'setor': 'Marketing - RJ',
          'descricao': 'Especialista em campanhas digitais.',
          'foto': 'https://randomuser.me/api/portraits/women/46.jpg',
        },
        {
          'nome': 'João Lima',
          'setor': 'Engenheiro - MG',
          'descricao': 'Engenheiro civil com 10 anos de experiência.',
          'foto': 'https://randomuser.me/api/portraits/men/49.jpg',
        },
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavLayout(
      currentIndex: 1, // posição do menu de "curtidas"
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
                  fontSize: 20,
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
                            'Sem mais perfis no momento.',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white70,
                            ),
                          ),
                        )
                        : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 12,
                                  crossAxisSpacing: 12,
                                  childAspectRatio: 0.75,
                                ),
                            itemCount: interesses.length,
                            itemBuilder: (context, index) {
                              return _buildCard(interesses[index]);
                            },
                          ),
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(Map<String, String> interesse) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF9C27B0).withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(interesse['foto']!),
            radius: 40,
          ),
          const SizedBox(height: 12),
          Text(
            interesse['nome']!,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            interesse['setor']!,
            style: const TextStyle(color: Colors.white70),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            interesse['descricao']!,
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
