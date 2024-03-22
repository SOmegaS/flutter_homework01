import 'article.dart';

/// Singleton for storing favorite articles
class Favorites {
  final Set<Article> favorites;

  Favorites() : favorites = {};
}
