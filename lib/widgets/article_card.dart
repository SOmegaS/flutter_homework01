import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:homework01/utils/callback_variable.dart';

import '../models/article.dart';
import '../services/favorites.dart';

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
      height: MediaQuery.of(context).size.height * 0.13,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.01,
          vertical: MediaQuery.of(context).size.height * 0.005,
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: (article.imageUrl != null)
                  ? CachedNetworkImage(
                      imageUrl: article.imageUrl!,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit.cover,
                      height: 70,
                    )
                  : const Icon(Icons.error),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.01,
                ),
                child: Text(
                  article.title ?? "",
                  style: Theme.of(context).textTheme.headlineMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                var favors = GetIt.instance.get<CallbackVariable<Favorites>>();
                favors.value.toggle(article);
                favors.update();
              },
              icon: const Icon(Icons.add_circle),
            ),
          ],
        ),
      ),
    );
  }
}
