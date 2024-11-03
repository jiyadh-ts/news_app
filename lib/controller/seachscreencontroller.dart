import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/model/new_res_model.dart';

class Searchscreencontroller with ChangeNotifier{
  NewsResModel? newsResModel;
  List<Article> newsArticles=[];
  bool isloading=false;
  

 Future<void> onSearch(String keyword)async{
    isloading=true;
    notifyListeners();
    final url=Uri.parse("https://newsapi.org/v2/everything?q=$keyword&apiKey=3d2744d6d8ac4003876bb307f8b59265");
    try{
      var res= await http.get(url);
      if(res.statusCode==200){
        newsResModel= newsResModelFromJson(res.body);
        if(newsResModel!=Null){
          newsArticles=newsResModel!.articles ?? [];
        }
      }
    }catch(e){
   print(e);
    }
    isloading=false;
    notifyListeners();

  }
}