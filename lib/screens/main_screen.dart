import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:homework01/utils/inherited_storage.dart';
import 'package:homework01/widgets/app_navigation_bar.dart';
import 'package:homework01/widgets/article_card.dart';
import 'package:homework01/models/article.dart';
import 'package:homework01/services/news_api.dart';
import 'package:homework01/screens/article_screen.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Main news screen
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<Article> articles = [];

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
    // Load articles
    _loadMoreData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// Open article's page
  void _openArticle(context, index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ArticleScreen(
          article: articles[index],
        ),
      ),
    );
  }

  /// Loads news to articles[] array
  void _loadMoreData() async {
    const int step = 10;
    var news = await GetIt.instance
        .get<NewsAPI>()
        .getNews(step, articles.length ~/ step + 1);
    articles.addAll(news);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.news,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          // Switch theme button
          IconButton(
            onPressed: () => InheritedStorage.of(context)["switchTheme"](),
            icon: const Icon(Icons.sunny),
          ),
          // Switch language button
          IconButton(
            onPressed: () => InheritedStorage.of(context)["switchLocale"](),
            icon: const Icon(Icons.language),
          ),
        ],
      ),
      bottomNavigationBar: const AppNavigationBar(currentScreen: Screen.main),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.02,
          vertical: MediaQuery.of(context).size.height * 0.01,
        ),
        child: ListView.builder(
          controller: _scrollController,
          itemCount: articles.length,
          itemBuilder: (BuildContext context, int index) {
            // Card with click detector
            return GestureDetector(
              onTap: () => _openArticle(context, index),
              child: ArticleCard(
                article: articles[index],
              ),
            );
          },
        ),
      ),
    );
  }
}
