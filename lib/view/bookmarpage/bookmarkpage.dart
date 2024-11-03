import 'package:flutter/material.dart';
import 'package:news_app/view/HomePage/detailscreen/detailscreen.dart';
import 'package:provider/provider.dart';
import 'package:news_app/controller/homescreencontroller.dart';
import 'package:news_app/controller/detailscreencontroller.dart';

class BookmarksPage extends StatelessWidget {
  const BookmarksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final homescreenController = Provider.of<Homescreencontroller>(context);
    final bookmarkedArticles = homescreenController.bookmarkedArticles;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "Bookmarks",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: bookmarkedArticles.isEmpty
          ? Center(
              child: Text(
                "No bookmarks yet",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(20.0),
              itemBuilder: (context, index) {
                final article = bookmarkedArticles[index];
                return GestureDetector(
                  onTap: () {
                    context.read<DetailScreenController>().setArticle(article);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (article.urlToImage != null)
                          ClipRRect(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(10)),
                            child: Image.network(
                              article.urlToImage!,
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 200,
                                  color: Colors.grey,
                                  child: Icon(
                                    Icons.broken_image,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                );
                              },
                            ),
                          )
                        else
                          Container(
                            height: 200,
                            color: Colors.grey,
                            child: Center(
                              child: Icon(
                                Icons.image_not_supported,
                                size: 50,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                article.title ?? 'No Title',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                article.description ?? 'No Description',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => Divider(
                color: Colors.white12,
              ),
              itemCount: bookmarkedArticles.length,
            ),
    );
  }
}
