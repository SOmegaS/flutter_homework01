import 'package:homework01/services/favorites.dart';

import '../models/article.dart';

/// Singleton for storing favorite articles
class FavoritesImpl implements Favorites {
  final Set<Article> _favorites;

  FavoritesImpl() : _favorites = {};

  @override
  operator [](index) {
    get(index);
  }

  @override
  bool contains(value) {
    return _favorites.contains(value);
  }

  @override
  get(index) {
    return _favorites.elementAt(index);
  }

  @override
  int length() {
    return _favorites.length;
  }

  @override
  void toggle(value) {
    if (_favorites.contains(value)) {
      _favorites.remove(value);
    } else {
      _favorites.add(value);
    }
  }
}
