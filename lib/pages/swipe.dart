import 'package:flutter/material.dart';
import 'package:interwork_app/widgets/main_layout.dart';
import 'package:swipe_cards/swipe_cards.dart';
import '../mock/vagas.dart';
import '../mock/candidatos.dart';
import '../mock/likes_candidatos.dart';
import '../mock/likes_recrutadores.dart';
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
  int _currentIndex = 0;

  // Mantém os IDs vistos durante a sessão
  static final Set<String> idsVistos = {};

  @override
  void initState() {
    super.initState();

    final mockData = widget.isCandidato ? vagasMock : candidatosMock;

    final naoVistos =
        mockData.where((data) {
          final id = data['id'];
          return id != null && !idsVistos.contains(id);
        }).toList();

    _swipeItems =
        naoVistos.map((data) {
          return SwipeItem(
            content: data,
            likeAction: () {
              final id = data['id'] ?? '';
              idsVistos.add(id);

              setState(() {
                if (widget.isCandidato) {
                  likesFeitosPeloCandidato.add(id);
                } else {
                  likesFeitosPeloRecrutador.add(id);
                }
              });

              final houveMatch =
                  widget.isCandidato
                      ? likesRecebidosCandidatos.contains(id)
                      : likesRecebidosRecrutadores.contains(id);

              if (houveMatch) {
                showMatchPopup(
                  context: context,
                  nomeOutroUsuario: data['nome'] ?? data['titulo'] ?? "",
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
              } else {
                print("Like enviado para $id. Ainda sem reciprocidade.");
              }
            },
            nopeAction: () {
              final id = data['id'] ?? '';
              idsVistos.add(id);
              print("Nope: ${data['nome'] ?? data['titulo']}");
            },
            superlikeAction: () {
              final id = data['id'] ?? '';
              idsVistos.add(id);
              print("SuperLike: ${data['nome'] ?? data['titulo']}");
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
              child: Image.asset(
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
                    colors: [Colors.transparent, Color(0xFF853EFF)],
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
                      backgroundImage: AssetImage(data['foto'] ?? ''),
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
