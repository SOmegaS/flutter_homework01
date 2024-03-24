/// Interface for favorites articles
/// Singleton
abstract class Favorites {
  /// Returns favorite article by index
  dynamic get(index);

  /// Count of favorites articles
  int length();

  /// Checks if article in favorites
  bool contains(value);

  /// Adds article if not contains, deletes otherwise
  void toggle(value);

  operator [](index) => get(index); // get
}
