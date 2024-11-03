import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:news_app/controller/detailscreencontroller.dart';
import 'package:news_app/controller/homescreencontroller.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final detailController = Provider.of<DetailScreenController>(context);
    final homescreenController = Provider.of<Homescreencontroller>(context);
    final article = detailController.selectedArticle;

    bool isBookmarked = article != null && homescreenController.isBookmarked(article);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        backgroundColor: Colors.black,
        title: Text(
          "News Details",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: article == null
          ? Center(child: Text("No article selected", style: TextStyle(color: Colors.white)))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (article.urlToImage != null)
                    Image.network(
                      article.urlToImage!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.broken_image, size: 50, color: Colors.white);
                      },
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
                  SizedBox(height: 20),
                  Text(
                    article.title ?? "No Title",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    article.content ?? "No content available.",
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            icon: Icon(Icons.thumb_up, color: Colors.white),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Liked!")),
                              );
                            },
                          ),
                          Text("Like", style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: Icon(Icons.comment, color: Colors.white),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Comment feature coming soon!")),
                              );
                            },
                          ),
                          Text("Comment", style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.bookmark,
                              color: isBookmarked ? Colors.blue : Colors.white,
                            ),
                            onPressed: () {
                              
                                homescreenController.toggleBookmark(article);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(isBookmarked
                                        ? "Removed from bookmarks"
                                        : "Added to bookmarks"),
                                  ),
                                );
                              
                            },
                          ),
                          Text("Bookmark", style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
