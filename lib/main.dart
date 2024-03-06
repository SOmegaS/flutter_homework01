import 'package:flutter/material.dart';
import 'package:homework01/main_page.dart';
import 'package:homework01/news_api.dart';
import 'package:homework01/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  ThemeMode _mode = ThemeMode.dark;
  Locale _locale = const Locale('ru');
  final List<NewDTO> _news = [];

  _AppState() {
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
      locale: _locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: InheritedExecutor(
        switchTheme: () => setState(() {
          if (_mode == ThemeMode.dark) {
            _mode = ThemeMode.light;
          } else {
            _mode = ThemeMode.dark;
          }
        }),
        switchLocale: () => setState(() {
          if (_locale.languageCode == 'en') {
            _locale = const Locale('ru');
          } else {
            _locale = const Locale('en');
          }
        }),
        child: MainPage(
          news: _news,
        ),
      ),
    );
  }
}
