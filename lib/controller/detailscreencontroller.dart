import 'package:flutter/material.dart';
import 'package:news_app/model/new_res_model.dart';

class DetailScreenController with ChangeNotifier {
  Article? selectedArticle;

  void setArticle(Article article) {
    selectedArticle = article;
    notifyListeners();
  }
}
