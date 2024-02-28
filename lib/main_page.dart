import 'package:flutter/material.dart';
import 'package:homework01/news_card.dart';
import 'package:homework01/news_page.dart';

import 'news_api.dart';

class MainPage extends StatelessWidget {
  final List<NewDTO> news;
  final Function() toggleTheme;

  const MainPage({super.key, required this.news, required this.toggleTheme});

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
      body: ListView(
        children: <Widget>[
          Switch(
            value: Theme.of(context).brightness == Brightness.light,
            onChanged: (bool state) => toggleTheme(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 30),
            child: Column(
              children: _createList(context),
            ),
          ),
        ],
      ),
    );
  }
}
