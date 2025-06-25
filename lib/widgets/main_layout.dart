// widgets/main_layout.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../pages/swipe.dart';
import '../pages/like_list.dart';
import '../pages/chat_list.dart';

class BottomNavLayout extends StatelessWidget {
  final int currentIndex;
  final Widget child;
  final bool isCandidato;

  const BottomNavLayout({
    super.key,
    required this.currentIndex,
    required this.child,
    required this.isCandidato,
  });

  void _onItemTapped(BuildContext context, int index) {
    if (index == currentIndex) return;

    Widget nextPage;
    switch (index) {
      case 0:
        nextPage = SwipeProfileScreen(isCandidato: isCandidato);
        break;
      case 1:
        nextPage = SwipeInteressesScreen(isCandidato: isCandidato);
        break;
      case 2:
        nextPage = ConversationsListScreen();
        break;
      default:
        return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => nextPage),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Conteúdo da tela
          Positioned.fill(child: child),

          // TopBar fixa e global
          const Positioned(top: 0, left: 0, right: 0, child: GlobalTopBar()),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => _onItemTapped(context, index),
        backgroundColor: const Color(0xFF3943FF),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'images/icons/logo.svg',
              color: currentIndex == 0 ? Colors.white : Colors.white70,
              height: 40,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'images/icons/vagas.svg',
              color: currentIndex == 1 ? Colors.white : Colors.white70,
              height: 40,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'images/icons/chat.svg',
              color: currentIndex == 2 ? Colors.white : Colors.white70,
              height: 40,
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}

class GlobalTopBar extends StatelessWidget {
  const GlobalTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: const BoxDecoration(color: Color(0xFFC23AFF)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                // TODO: Ação para configurações
              },
              child: SvgPicture.asset(
                'images/icons/settings.svg',
                height: 28,
                width: 28,
                color: Colors.white,
              ),
            ),
            SvgPicture.asset(
              'images/icons/logotexto.svg', // texto "interwork" como SVG
              height: 28,
              color: Colors.white,
            ),
            GestureDetector(
              onTap: () {
                // TODO: Ação para perfil
              },
              child: SvgPicture.asset(
                'images/icons/user.svg',
                height: 28,
                width: 28,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
