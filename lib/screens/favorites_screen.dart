import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:homework01/widgets/article_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/favorites.dart';
import 'article_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<StatefulWidget> createState() => FavoritesScreenState();
}

class FavoritesScreenState extends State<FavoritesScreen> {
  /// Open article's page
  void _openArticle(context, index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ArticleScreen(
          article: GetIt.instance.get<Favorites>().favorites.elementAt(index),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.back),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              child: ListView.builder(
                itemCount: GetIt.instance.get<Favorites>().favorites.length,
                itemBuilder: (BuildContext context, int index) {
                  // Card with click detector
                  return GestureDetector(
                    onTap: () => _openArticle(context, index),
                    child: ArticleCard(
                      article: GetIt.instance
                          .get<Favorites>()
                          .favorites
                          .elementAt(index),
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
