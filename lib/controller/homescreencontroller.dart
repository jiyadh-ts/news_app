// homescreencontroller.dart
import 'package:flutter/material.dart';
import 'package:news_app/model/new_res_model.dart';
import 'package:http/http.dart' as http;

class Homescreencontroller with ChangeNotifier {
  NewsResModel? newsResModel;
  List<Article> newsArticles = [];
  bool isloading = false;

  // List to hold bookmarked articles
  List<Article> bookmarkedArticles = [];

  Future<void> getNews() async {
    isloading = true;
    notifyListeners();
    final url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=3d2744d6d8ac4003876bb307f8b59265");
    try {
      var res = await http.get(url);
      if (res.statusCode == 200) {
        newsResModel = newsResModelFromJson(res.body);
        if (newsResModel != null) {
          newsArticles = newsResModel!.articles ?? [];
        }
      }
    } catch (e) {
      print(e);
    }
    isloading = false;
    notifyListeners();
  }

  void toggleBookmark(Article article) {
    if (isBookmarked(article)) {
      bookmarkedArticles.removeWhere((a) => a.url == article.url);
    } else {
      bookmarkedArticles.add(article);
    }
    notifyListeners();
  }

  bool isBookmarked(Article article) {
    return bookmarkedArticles.any((a) => a.url == article.url);
  }
}
