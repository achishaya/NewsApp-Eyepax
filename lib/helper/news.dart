import 'package:http/http.dart' as http;
import 'package:news_app_api/models/article.dart';
import 'dart:convert';

import 'package:news_app_api/secret.dart';

class News {

  List<Article> news  = [];
  List<Article> topNews = [];

  Future<void> getNews() async{
    String url = "http://newsapi.org/v2/everything?q=a&sortBy=publishedAt&language=en&apiKey=feae8e4644d64ed3abf6db60952ebd7a";
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){
        if(element['urlToImage'] != null && element['description'] != null){
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publshedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          news.add(article);
        }
      });
    }
  }

  Future<void> getTopNews() async{
    String url = "http://newsapi.org/v2/top-headlines?sortBy=publishedAt&language=en&apiKey=feae8e4644d64ed3abf6db60952ebd7a";
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){
        if(element['urlToImage'] != null && element['description'] != null){
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publshedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          topNews.add(article);
        }
      });
    }
  }
}


class NewsForCategorie {

  List<Article> news  = [];

  Future<void> getNewsForCategory(String category) async{

    String url = "http://newsapi.org/v2/everything?q=$category&apiKey=feae8e4644d64ed3abf6db60952ebd7a";
    print(category);
//    String url = "http://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=feae8e4644d64ed3abf6db60952ebd7a";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){

        if(element['urlToImage'] != null && element['description'] != null){
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publshedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          news.add(article);
        }

      });
    }


  }


}


