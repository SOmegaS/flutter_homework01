import 'package:homework01/models/article.dart';

abstract class NewsAPI {
  Future<List<Article>> getNews(int? pageSize, int? page);
}
