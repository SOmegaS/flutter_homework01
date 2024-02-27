import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  final String title;
  final AssetImage image;

  const NewsCard({super.key, required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 150,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: <Widget>[
              Image(image: image, fit: BoxFit.contain),
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
