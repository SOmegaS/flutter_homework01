import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:homework01/screens/favorites_screen.dart';
import 'package:homework01/utils/inherited_storage.dart';
import 'package:homework01/widgets/article_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/article.dart';
import '../services/news_api.dart';
import 'article_screen.dart';

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
        title: Text(AppLocalizations.of(context)!.news),
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
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FavoritesScreen()),
            ),
            child: Text(AppLocalizations.of(context)!.favorites),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
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
          ),
        ],
      ),
    );
  }
}
