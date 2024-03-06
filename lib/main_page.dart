import 'package:flutter/material.dart';
import 'package:homework01/news_card.dart';
import 'package:homework01/news_page.dart';
import 'package:homework01/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'news_api.dart';

class MainPage extends StatelessWidget {
  final List<NewDTO> news;

  const MainPage({super.key, required this.news});

  void _openNews(context, index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewsPage(
          title: news[index].title ?? "",
          text: news[index].text ?? "",
          link: news[index].url ?? "",
          image: const AssetImage("assets/img.png"),
        ),
      ),
    );
  }

  List<Widget> _createList(context) {
    List<Widget> res = [];

    for (int i = 0; i < news.length; ++i) {
      res.add(GestureDetector(
        onTap: () => _openNews(context, i),
        child: NewsCard(title: news[i].title ?? "", image: const AssetImage("assets/img.png")),
      ));
    }

    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 30),
                  child: Column(
                    children: _createList(context),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.theme,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    Switch(
                      value: Theme.of(context).brightness == Brightness.light,
                      onChanged: (bool state) {
                        InheritedExecutor.of(context).switchTheme();
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.locale,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    Switch(
                      value: Localizations.localeOf(context).languageCode == 'en',
                      onChanged: (bool state) {
                        InheritedExecutor.of(context).switchLocale();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
