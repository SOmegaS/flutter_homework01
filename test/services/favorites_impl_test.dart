import 'package:flutter_test/flutter_test.dart';
import 'package:homework01/models/article.dart';
import 'package:homework01/services/favorites.dart';
import 'package:homework01/services/favorites_impl.dart';

void main() {
  late Favorites favorites;
  late Article article;

  setUp(() {
    favorites = FavoritesImpl();
    article = Article();
  });

  test(
    "Должен записать статью и она должна быть видна",
    () {
      favorites.toggle(article);
      expect(favorites.contains(article), true);
      expect(favorites.length(), 1);
    },
  );

  test(
    "Не записанной статьи не должно быть",
    () {
      expect(favorites.contains(article), false);
      expect(favorites.length(), 0);
    },
  );

  test(
    "Записанная и убранная статья должна быть не видна",
    () {
      favorites.toggle(article);
      favorites.toggle(article);
      expect(favorites.contains(article), false);
      expect(favorites.length(), 0);
    },
  );
}
