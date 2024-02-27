import 'package:flutter/material.dart';
import 'package:homework01/news_card.dart';
import 'package:homework01/news_page.dart';

class MainPage extends StatelessWidget {
  final List<String> titles;
  final List<AssetImage> images;
  final Function() toggleTheme;

  const MainPage({super.key, required this.titles, required this.images, required this.toggleTheme});

  void _openNews(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewsPage(
          title: titles[0],
          text: "text",
          link: "link",
          image: images[0],
        ),
      ),
    );
  }

  List<Widget> _createList(context) {
    List<Widget> res = [];

    for (int i = 0; i < titles.length; ++i) {
      res.add(GestureDetector(
        onTap: () => _openNews(context),
        child: NewsCard(title: titles[i], image: images[i]),
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
