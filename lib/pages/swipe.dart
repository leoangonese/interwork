import 'package:flutter/material.dart';
import 'package:interwork_app/widgets/bottom_nav_layout.dart';
import 'package:swipe_cards/swipe_cards.dart';
import '../mock/vagas.dart';
import '../mock/candidatos.dart';
import './chat_list.dart';
import './like_list.dart';
import './match.dart'; // ajuste se necessário

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
  int _selectedIndex = 0;
  int _currentIndex = 0;

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
                imageUrlEmpresa: data['foto'] ?? '',
                imageUrlPessoa:
                    'https://images.unsplash.com/photo-1599566150163-29194dcaad36?q=80&w=1287&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                onChatPressed: () {
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
              print("Nope: \${data['nome'] ?? data['titulo']}");
            },
            superlikeAction: () {
              print("SuperLike: \${data['nome'] ?? data['titulo']}");
            },
          );
        }).toList();

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavLayout(
      currentIndex: 0,
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
          child: SwipeCards(
            matchEngine: _matchEngine,
            itemBuilder: (context, index) {
              final data = _swipeItems[index].content as Map<String, String>;
              return Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFC73AFF), Color(0xFF3943FF)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: _buildProfile(data),
              );
            },
            onStackFinished: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Você visualizou todas as opções!"),
                ),
              );
            },
            itemChanged: (item, index) {
              setState(() {
                _currentIndex = index;
              });
            },
            upSwipeAllowed: true,
            fillSpace: true,
          ),
        ),
      ),
    );
  }

  Widget _buildProfile(Map<String, String> data) {
    final media = MediaQuery.of(context).size;
    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: media.height * 0.4,
              child: Image.network(
                data['banner'] ?? '',
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
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 80,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Color(0xFFC73AFF)],
                  ),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 54,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: const Color.fromARGB(255, 73, 6, 102),
                      backgroundImage: NetworkImage(data['foto'] ?? ''),
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
                      color: Color(0xFFF0D9FF),
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
