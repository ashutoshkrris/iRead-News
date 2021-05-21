import 'dart:convert';
import 'package:news_app/models/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<Article> news = [];

  Future<void> getHeadlines() async {
    var apiUrl = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&apiKey=8c0870689fd0492098ea2a1bf26edaa3");

    var response = await http.get(apiUrl);
    var jsonData = jsonDecode(response.body);

    if (jsonData["status"] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element['title'] != null &&
            element['author'] != null &&
            element["content"] != null &&
            element["urlToImage"] != null &&
            element["description"] != null) {
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publishedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          news.add(article);
        }
      });
    }
  }
}
