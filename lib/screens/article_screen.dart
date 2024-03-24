import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/article.dart';

/// Screen with one article
class ArticleScreen extends StatelessWidget {
  final Article article;

  const ArticleScreen({
    super.key,
    required this.article,
  });

  /// Opens browser on article's link
  void _launchLink() async {
    if (article.url == null) {
      throw 'url not defined';
    }
    Uri uri = Uri.parse(article.url!);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.03,
              vertical: MediaQuery.of(context).size.height * 0.02,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                (article.imageUrl != null)
                    ? CachedNetworkImage(
                        imageUrl: article.imageUrl!,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      )
                    : const Icon(Icons.error),
                Text(
                  article.title ?? "",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  article.text ?? "",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                // Link click detector
                GestureDetector(
                  onTap: _launchLink,
                  child: Text(
                    AppLocalizations.of(context)!.read_more,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    AppLocalizations.of(context)!.back,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
