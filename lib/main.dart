import 'package:flutter/material.dart';
import 'package:homework01/main_page.dart';
import 'package:homework01/news_api.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  ThemeMode _mode;
  List<NewDTO> _news;

  _AppState(): _mode=ThemeMode.dark, _news=[] {
    getTopStories().then((newsID) {
      for (int i = 0; i < newsID.length; ++i) {
        getNew(newsID[i]).then((value) {
          if (value.title != null && value.text != null && value.text != "") {
            _news.add(value);
          }
          if (_news.length % 10 == 9 || i == newsID.length - 1) {
            setState(() {});
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News app',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _mode,
      home: MainPage(
        news: _news,
        toggleTheme: () => setState(() {
          if (_mode == ThemeMode.light) {
            _mode = ThemeMode.dark;
          } else {
            _mode = ThemeMode.light;
          }
        }),
      ),
    );
  }
}
