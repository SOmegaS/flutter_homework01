import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Page with one news
class NewsPage extends StatelessWidget {
  final String title;
  final String text;
  final String link;
  final Image image;

  const NewsPage({
    super.key,
    required this.title,
    required this.text,
    required this.link,
    required this.image,
  });

  /// Opens browser on news link
  void _launchLink() async {
    Uri uri = Uri.parse(link);
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
            padding: const EdgeInsets.symmetric(horizontal: 200, vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(image: image.image),
                Text(title, style: Theme.of(context).textTheme.headlineMedium),
                Text(text, style: Theme.of(context).textTheme.bodyLarge),
                // Link click detector
                GestureDetector(
                  onTap: _launchLink,
                  child: Text(AppLocalizations.of(context)!.read_more, style: Theme.of(context).textTheme.labelSmall),
                ),
                ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text("Назад")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
