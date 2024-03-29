import 'package:flutter/material.dart';

/// Card with one news
class NewsCard extends StatelessWidget {
  final String title;
  final Image image;

  const NewsCard({super.key, required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 150,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              Image(image: image.image, fit: BoxFit.contain, height: 70),
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.headlineMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}
