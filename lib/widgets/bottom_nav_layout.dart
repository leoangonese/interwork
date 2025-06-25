// widgets/bottom_nav_layout.dart
import 'package:flutter/material.dart';
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
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => _onItemTapped(context, index),
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
}
