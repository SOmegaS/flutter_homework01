@Timeout(Duration(seconds: 5))

import 'package:flutter_test/flutter_test.dart';
import 'package:homework01/services/news_api.dart';
import 'package:homework01/services/news_api_org.dart';

void main() {
  late NewsAPI newsAPI;

  setUpAll(() {
    newsAPI = NewsApiOrg();
  });

  test(
    "Должны прийти новости",
    () async {
      int pageSize = 10;
      int page = 1;
      var resp = await newsAPI.getNews(pageSize, page);
      expect(resp.length, pageSize);
    },
  );
}
