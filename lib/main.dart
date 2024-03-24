import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:homework01/services/favorites.dart';
import 'package:homework01/services/favorites_impl.dart';
import 'package:homework01/screens/main_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:homework01/services/news_api.dart';
import 'package:homework01/services/news_api_org.dart';
import 'package:homework01/utils/callback_variable.dart';
import 'package:homework01/utils/inherited_storage.dart';

void main() {
  initDependencies();
  runApp(const App());
}

/// Init dependencies
void initDependencies() {
  GetIt.instance.registerSingleton<CallbackVariable<Favorites>>(
      CallbackVariable(FavoritesImpl()));
  GetIt.instance.registerSingleton<NewsAPI>(NewsApiOrg());
}

/// Main app
class App extends StatefulWidget {
  const App({super.key});

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  ThemeMode _mode = ThemeMode.dark;
  Locale _locale = const Locale('ru');

  /// Switches app theme
  void switchTheme() {
    setState(() {
      if (_mode == ThemeMode.dark) {
        _mode = ThemeMode.light;
      } else {
        _mode = ThemeMode.dark;
      }
    });
  }

  /// Switches app language
  void switchLocale() {
    setState(() {
      if (_locale.languageCode == 'en') {
        _locale = const Locale('ru');
      } else {
        _locale = const Locale('en');
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
      // To access variables anywhere down the tree
      home: InheritedStorage(
        context: context,
        map: {
          "switchTheme": switchTheme,
          "switchLocale": switchLocale,
        },
        child: const MainScreen(),
      ),
    );
  }
}
