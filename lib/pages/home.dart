import 'package:flutter/material.dart';
import 'package:interwork_app/pages/match.dart';
import 'package:swipe_cards/swipe_cards.dart';
import './chat_list.dart';
import './like_list.dart';

List<Map<String, String>> vagasMock = [
  {
    'banner':
        'https://blog.emania.com.br/wp-content/uploads/2016/02/direitos-autorais-e-de-imagem.jpg',
    'foto':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTCbVVhxA-HjtuVFPredX_fSg0jT-dL9BJxAw&s',
    'titulo': 'Desenvolvedor Flutter',
    'setor': 'Tecnologia',
    'localizacao': 'São Paulo - SP',
    'descricao':
        'Desenvolvimento de aplicativos mobile com Flutter e Dart. Ambiente ágil.',
  },
  {
    'banner': 'https://via.placeholder.com/400x150',
    'foto': 'https://via.placeholder.com/100',
    'titulo': 'Desenvolvedor Flutter',
    'setor': 'Tecnologia',
    'localizacao': 'São Paulo - SP',
    'descricao':
        'Desenvolvimento de aplicativos mobile com Flutter e Dart. Ambiente ágil.',
  },
];

List<Map<String, String>> candidatosMock = [
  {
    'banner': 'https://via.placeholder.com/400x150',
    'foto': 'https://via.placeholder.com/100',
    'nome': 'João Silva',
    'setor': 'Tecnologia',
    'localizacao': 'Rio de Janeiro - RJ',
    'funcao': 'Desenvolvedor Fullstack',
    'descricao':
        'Experiência em Flutter, Node.js e React. Apaixonado por resolver problemas.',
  },
];

class SwipeProfileScreen extends StatefulWidget {
  final bool isCandidato;

  const SwipeProfileScreen({Key? key, required this.isCandidato})
    : super(key: key);

  @override
  _SwipeProfileScreenState createState() => _SwipeProfileScreenState();
}

class _SwipeProfileScreenState extends State<SwipeProfileScreen> {
  late MatchEngine _matchEngine;
  List<SwipeItem> _swipeItems = [];

  int _selectedIndex =
      0; // para controlar o menu inferior (mesmo que não faça nada por enquanto)

  @override
  void initState() {
    super.initState();

    Set<String> likesIds = {};
    List<Map<String, String>> mockData =
        widget.isCandidato ? vagasMock : candidatosMock;

    _swipeItems =
        mockData.map((data) {
          return SwipeItem(
            content: data,
            likeAction: () {
              final id = data['nome'] ?? data['titulo'];

              setState(() {
                likesIds.add(id ?? "");
              });
              showMatchPopup(
                context: context,
                nomeOutroUsuario: id ?? "",
                imageUrlEmpresa:
                    'https://images.unsplash.com/photo-1719253480609-579ad1622c65?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                imageUrlPessoa:
                    'https://images.unsplash.com/photo-1599566150163-29194dcaad36?q=80&w=1287&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                onChatPressed: () {
                  // Navegue para a tela de chat aqui
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ConversationsListScreen(),
                    ),
                  );
                },
              );
            },

            nopeAction: () {
              print("Nope: ${data['nome'] ?? data['titulo']}");
            },
            superlikeAction: () {
              print("SuperLike: ${data['nome'] ?? data['titulo']}");
            },
          );
        }).toList();

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
  }

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;

    setState(() {
      _selectedIndex = index;
    });

    // Defina a navegação com base no índice
    switch (index) {
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const SwipeInteressesScreen(isCandidato: true),
          ),
        );

        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ConversationsListScreen()),
        );

        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // fundo do app com gradiente
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFC73AFF), Color(0xFF3943FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SwipeCards(
            matchEngine: _matchEngine,
            itemBuilder: (BuildContext context, int index) {
              final data = _swipeItems[index].content as Map<String, String>;
              return _buildProfile(data);
            },
            onStackFinished: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Você visualizou todas as opções!"),
                ),
              );
            },
            itemChanged: (SwipeItem item, int index) {
              print("Item mudado: $index");
            },
            upSwipeAllowed: true,
            fillSpace: true,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: const Color(0xFF3943FF),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: ''),
        ],
      ),
    );
  }

  Widget _buildProfile(Map<String, String> data) {
    final media = MediaQuery.of(context).size;
    return Column(
      children: [
        // Banner no topo - altura 40% da tela e largura total
        SizedBox(
          width: double.infinity,
          height: media.height * 0.4,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                data['banner']!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(
                        Icons.broken_image,
                        size: 50,
                        color: Colors.grey,
                      ),
                    ),
                  );
                },
              ),
              // Overlay leve para contraste
              Container(color: Colors.black.withOpacity(0.3)),
            ],
          ),
        ),
        // Informações abaixo da imagem
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              color: Colors.white, // usa fundo do gradiente do pai
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Foto perfil circular com borda branca
                  CircleAvatar(
                    radius: 54,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(data['foto']!),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    data['nome'] ?? data['titulo'] ?? '',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 4,
                          color: Colors.black54,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    data['setor'] ?? '',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Color(0xFFC73AFF),
                      fontWeight: FontWeight.w600,
                      shadows: [
                        Shadow(
                          blurRadius: 3,
                          color: Colors.black45,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    data['localizacao'] ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                      fontWeight: FontWeight.w400,
                      shadows: [
                        Shadow(
                          blurRadius: 3,
                          color: Colors.black45,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.isCandidato
                        ? (data['titulo'] ?? '')
                        : (data['funcao'] ?? ''),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 3,
                          color: Colors.black54,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      data['descricao'] ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                        height: 1.4,
                        shadows: [
                          Shadow(
                            blurRadius: 3,
                            color: Colors.black38,
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
