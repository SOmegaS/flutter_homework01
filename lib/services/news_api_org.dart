import 'package:homework01/models/article.dart';
import 'package:homework01/services/news_api.dart';
import 'package:news_api_flutter_package/news_api_flutter_package.dart'
    as news_api;

/// Implementation NewsApi based on NewsApi.org
/// Singleton
class NewsApiOrg implements NewsAPI {
  /// Instance for queries to NewsApi.org
  final _newsAPI = news_api.NewsAPI(apiKey: "a65c9ebbe91843da82d6c84ea652d980");

  /// Queries for top headlines news in US
  @override
  Future<List<Article>> getNews(int? pageSize, int? page) async {
    var news = await _newsAPI.getTopHeadlines(
        country: "us", pageSize: pageSize, page: page);

    List<Article> articles = [];
    for (int i = 0; i < news.length; ++i) {
      articles.add(Article(
        title: news[i].title,
        text: news[i].description,
        url: news[i].url,
        imageUrl: news[i].urlToImage,
      ));
    }
    return articles;
  }
}
