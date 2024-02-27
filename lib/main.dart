import 'package:flutter/material.dart';
import 'package:homework01/main_page.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  _AppState(): mode=ThemeMode.dark;

  ThemeMode mode;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News app',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: mode,
      home: MainPage(
        titles: ["Заголовок"*100, "Заголовок"*100, "Заголовок"*100],
        images: const [AssetImage("assets/img.png"), AssetImage("assets/img.png"), AssetImage("assets/img.png")],
        toggleTheme: () => setState(() {
          if (mode == ThemeMode.light) {
            mode = ThemeMode.dark;
          } else {
            mode = ThemeMode.light;
          }
        }),
      ),
    );
  }
}