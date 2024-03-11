import 'dart:math';
import 'package:flutter/material.dart';
import 'package:homework01/news_card.dart';
import 'package:homework01/news_page.dart';
import 'package:homework01/inherited_executor.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'news_api.dart';

class MainPage extends StatefulWidget {
  final List<int> newsID;

  const MainPage({super.key, required this.newsID});

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final ScrollController _scrollController = ScrollController();
  final List<NewDTO> news = [];
  int visible = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMoreData();
      }
    });
    _loadMoreData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _openNews(context, index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewsPage(
          title: news[index].title ?? "",
          text: news[index].text ?? "",
          link: news[index].url ?? "",
          image: const AssetImage("assets/img.png"),
        ),
      ),
    );
  }

  void _loadMoreData() async {
    const int step = 10;
    for (int i = visible; i < min(visible + step, widget.newsID.length) && mounted; ++i) {
      var value = await getNew(widget.newsID[i]);
      if (value.title == null && (value.text == null || value.text == "")) {
        continue;
      }
      value.title = value.title ?? value.text?.split(' ')[0];
      value.text = value.text ?? value.title;
      news.add(value);
    }
    if (mounted) {
      setState(() {
        visible = min(visible + step, widget.newsID.length);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              child: ListView.builder(
                controller: _scrollController,
                itemCount: visible,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () => _openNews(context, index),
                    child: NewsCard(
                        title: news[index].title ?? "",
                        image: const AssetImage("assets/img.png")),
                  );
                },
              ),
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
                      value:
                          Localizations.localeOf(context).languageCode == 'en',
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
