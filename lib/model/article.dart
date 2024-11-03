// lib/model/article.dart

import 'package:hive/hive.dart';

part 'article.g.dart';

@HiveType(typeId: 0) // Ensure typeId is unique across all your models
class Article {
  @HiveField(0)
  final String? title;

  @HiveField(1)
  final String? url;

  @HiveField(2)
  final String? description;

  @HiveField(3)
  final String? urlToImage;

  @HiveField(4)
  
  final String? content;

  // Add other fields as necessary

  Article({
    this.title,
    this.url,
    this.description,
    this.urlToImage,
    this.content,
  });

  // Factory methods to map between API data and Hive
  factory Article.fromJson(Map<String, dynamic> json) => Article(
        title: json["title"],
        url: json["url"],
        description: json["description"],
        urlToImage: json["urlToImage"],
      
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "url": url,
        "description": description,
        "urlToImage": urlToImage,
        "content": content,
      };
}
