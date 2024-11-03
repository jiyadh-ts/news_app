import 'package:flutter/material.dart';
import 'package:news_app/controller/detailscreencontroller.dart';
import 'package:news_app/controller/homescreencontroller.dart';
import 'package:news_app/view/HomePage/detailscreen/detailscreen.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<Homescreencontroller>().getNews();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<Homescreencontroller>();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
          child: Text(
            "NewsApp",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Icon(
              Icons.notifications,
              color: Colors.grey,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Trending News For You",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Builder(builder: (context) {
                if (provider.isloading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (provider.newsArticles.isEmpty) {
                  return Center(
                    child: Text(
                      "No results found",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                } else {
                  return ListView.separated(
                    padding: const EdgeInsets.all(8.0),
                    itemBuilder: (context, index) {
                      final article = provider.newsArticles[index];
                      return GestureDetector(
                        onTap: () {
                          context
                              .read<DetailScreenController>()
                              .setArticle(article);
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
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(10)),
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
                    itemCount: provider.newsArticles.length,
                  );
                }
              }),
            )
          ],
        ),
      ),
    );
  }
}
