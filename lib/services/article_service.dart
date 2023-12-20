import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mod_android/model/article/Article.dart';
import 'package:mod_android/theme.dart';

class ArticleService {
  Future<List<Article>> getArticles() async {
    var url = urlApi + 'api/articles';
    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(Uri.parse(url), headers: headers);

    print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data'];
      List<Article> articles = [];

      for (var item in data) {
        articles.add(Article.fromJson(item));
      }
      return articles;
    } else {
      throw Exception('Failed to get articles!');
    }
  }
}
