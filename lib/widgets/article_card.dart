import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../models/article.dart';
import '../models/favorites.dart';

/// Card with one article
class ArticleCard extends StatelessWidget {
  final Article article;

  const ArticleCard({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            (article.imageUrl != null)
                ? CachedNetworkImage(
                    imageUrl: article.imageUrl!,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit.contain,
                    height: 70,
                  )
                : const Icon(Icons.error),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                child: Text(
                  article.title ?? "",
                  style: Theme.of(context).textTheme.headlineMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                Set favors = GetIt.instance.get<Favorites>().favorites;
                if (favors.contains(article)) {
                  favors.remove(article);
                } else {
                  favors.add(article);
                }
              },
              icon: const Icon(Icons.add_circle),
            ),
          ],
        ),
      ),
    );
  }
}
