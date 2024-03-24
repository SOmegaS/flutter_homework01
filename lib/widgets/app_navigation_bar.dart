import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:homework01/screens/favorites_screen.dart';
import 'package:homework01/screens/main_screen.dart';

enum Screen {
  main,
  favorites,
}

class AppNavigationBar extends StatelessWidget {
  final Screen currentScreen;

  const AppNavigationBar({
    super.key,
    required this.currentScreen,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentScreen.index,
      onTap: (index) {
        Widget screen;
        switch (Screen.values[index]) {
          case Screen.main:
            screen = const MainScreen();
          case Screen.favorites:
            screen = const FavoritesScreen();
        }
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => screen,
          ),
        );
      },
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: AppLocalizations.of(context)!.home,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.favorite),
          label: AppLocalizations.of(context)!.favorites,
        ),
      ],
    );
  }
}
