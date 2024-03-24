import 'package:homework01/models/article.dart';

/// Interface for NewsAPI's realizations
/// Singleton
abstract class NewsAPI {
  /// Queries service for news array
  Future<List<Article>> getNews(int? pageSize, int? page);
}
