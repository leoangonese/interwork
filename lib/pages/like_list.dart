import 'package:flutter/material.dart';

class SwipeInteressesScreen extends StatefulWidget {
  final bool isCandidato;

  const SwipeInteressesScreen({Key? key, required this.isCandidato}) : super(key: key);

  @override
  State<SwipeInteressesScreen> createState() => _SwipeInteressesScreenState();
}

class _SwipeInteressesScreenState extends State<SwipeInteressesScreen> {
  List<Map<String, String>> interesses = [];

  double positionX = 0;
  double positionY = 0;
  double angle = 0;

  @override
  void initState() {
    super.initState();

    if (widget.isCandidato) {
      interesses = [
        {
          'nome': 'Empresa A',
          'setor': 'Tecnologia - SP',
          'descricao': 'Procuramos desenvolvedores Flutter.',
          'foto': 'https://randomuser.me/api/portraits/men/45.jpg'
        },
        {
          'nome': 'Empresa B',
          'setor': 'Marketing - RJ',
          'descricao': 'Vaga para analista de marketing.',
          'foto': 'https://randomuser.me/api/portraits/men/46.jpg'
        },
        {
          'nome': 'Empresa C',
          'setor': 'Finanças - RJ',
          'descricao': 'Vaga para analista financeiro.',
          'foto': 'https://randomuser.me/api/portraits/men/48.jpg'
        },
        {
          'nome': 'Empresa D',
          'setor': 'RH - SP',
          'descricao': 'Vaga para assistente de RH.',
          'foto': 'https://randomuser.me/api/portraits/women/45.jpg'
        },
      ];
    } else {
      interesses = [
        {
          'nome': 'Maria Silva',
          'setor': 'Designer - BH',
          'descricao': 'Profissional criativa e dedicada.',
          'foto': 'https://randomuser.me/api/portraits/women/44.jpg'
        },
        {
          'nome': 'Carlos Souza',
          'setor': 'Desenvolvedor - SP',
          'descricao': 'Especialista em mobile e web.',
          'foto': 'https://randomuser.me/api/portraits/men/47.jpg'
        },
        {
          'nome': 'Ana Pereira',
          'setor': 'Marketing - RJ',
          'descricao': 'Especialista em campanhas digitais.',
          'foto': 'https://randomuser.me/api/portraits/women/46.jpg'
        },
        {
          'nome': 'João Lima',
          'setor': 'Engenheiro - MG',
          'descricao': 'Engenheiro civil com 10 anos de experiência.',
          'foto': 'https://randomuser.me/api/portraits/men/49.jpg'
        },
      ];
    }
  }

  void _onDragUpdate(DragUpdateDetails details) {
    setState(() {
      positionX += details.delta.dx;
      positionY += details.delta.dy;
      angle = positionX / 200;
    });
  }

  void _onDragEnd() {
    if (positionX > 100) {
      _like();
    } else if (positionX < -100) {
      _dislike();
    } else {
      setState(() {
        positionX = 0;
        positionY = 0;
        angle = 0;
      });
    }
  }

  void _like() {
    if (interesses.isEmpty) return;
    setState(() {
      interesses.removeAt(0);
      positionX = 0;
      positionY = 0;
      angle = 0;
    });
  }

  void _dislike() {
    if (interesses.isEmpty) return;
    setState(() {
      interesses.removeAt(0);
      positionX = 0;
      positionY = 0;
      angle = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isCandidato ? 'Vagas que curtiram você' : 'Candidatos interessados'),
        centerTitle: true,
        backgroundColor: const Color(0xFF3943FF),
      ),
      body: interesses.isEmpty
          ? const Center(
              child: Text(
                'Sem mais perfis no momento.',
                style: TextStyle(fontSize: 18),
              ),
            )
          : Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // duas colunas
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.75, // para ajustar a proporção do card (altura/largura)
          ),
          itemCount: interesses.length,
          itemBuilder: (context, index) {
            return _buildCard(interesses[index]);
          },
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
          ),
          const SizedBox(height: 6),
          Text(
            interesse['setor']!,
            style: const TextStyle(color: Colors.white70),
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
