import 'package:flutter/material.dart';
import 'package:homework01/main.dart';
import 'package:homework01/widgets/news_card.dart';
import 'package:homework01/utils/inherited_executor.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_api_flutter_package/model/article.dart';

import 'news_page.dart';

/// Main news page
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final defaultUrl = "https://upload.wikimedia.org/wikipedia/commons/a/a8/NASA-Apollo8-Dec24-Earthrise.jpg";
  final ScrollController _scrollController = ScrollController();
  final List<Article> news = [];

  @override
  void initState() {
    super.initState();
    // On scroll
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMoreData();
      }
    });
    // Load news
    _loadMoreData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// Open news page
  void _openNews(context, index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewsPage(
          title: news[index].title ?? "",
          text: news[index].description ?? "",
          link: news[index].url ?? "",
          image: Image.network(news[index].urlToImage ?? defaultUrl),
        ),
      ),
    );
  }

  /// Loads news to news[] array
  void _loadMoreData() async {
    const int step = 10;
    var value = await App.newsAPI.getTopHeadlines(country: "us", pageSize: step, page: news.length ~/ step + 1);
    news.addAll(value);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.news),
        actions: [
          // Switch theme button
          IconButton(
            onPressed: () => InheritedExecutor.of(context).switchTheme(),
            icon: const Icon(Icons.sunny),
          ),
          // Switch language button
          IconButton(
            onPressed: () => InheritedExecutor.of(context).switchLocale(),
            icon: const Icon(Icons.language),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              child: ListView.builder(
                controller: _scrollController,
                itemCount: news.length,
                itemBuilder: (BuildContext context, int index) {
                  // Card with click detector
                  return GestureDetector(
                    onTap: () => _openNews(context, index),
                    child: NewsCard(
                        title: news[index].title ?? "",
                        image: Image.network(news[index].urlToImage ?? defaultUrl),
                    )
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
