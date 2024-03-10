import 'package:flutter/material.dart';
import 'package:homework01/main_page.dart';
import 'package:homework01/news_api.dart';
import 'package:homework01/inherited_executor.dart';
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
  late List<int> _news;

  Future<bool> waitForNews() async {
    _news = await getTopStories();
    return true;
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
        child: FutureBuilder(
          future: waitForNews(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done && !snapshot.hasError && snapshot.hasData) {
              return MainPage(
                newsID: _news,
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
