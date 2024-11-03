import 'package:flutter/material.dart';
import 'package:news_app/controller/detailscreencontroller.dart';
import 'package:news_app/controller/seachscreencontroller.dart';
import 'package:news_app/view/HomePage/detailscreen/detailscreen.dart';
import 'package:provider/provider.dart';

class Searchscreen extends StatefulWidget {
  const Searchscreen({super.key});

  @override
  State<Searchscreen> createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen>
    with SingleTickerProviderStateMixin {
  late TextEditingController searchcontroller;
  late TabController tabController;

  final List<String> categories = [
    'Business',
    'Entertainment',
    'Health',
    'Science',
    'Sports',
    'Technology'
  ];

  @override
  void initState() {
    super.initState();
    searchcontroller = TextEditingController();
    tabController = TabController(length: categories.length, vsync: this);
  }

  @override
  void dispose() {
    searchcontroller.dispose();
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<Searchscreencontroller>();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: TextField(
                controller: searchcontroller,
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: 'Search news...',
                  hintStyle: TextStyle(color: Colors.white60),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                ),
                onSubmitted: (value) {
                  if (value.trim().isNotEmpty) {
                    context
                        .read<Searchscreencontroller>()
                        .onSearch(value.trim());
                  }
                },
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    context
                        .read<Searchscreencontroller>()
                        .onSearch(searchcontroller.text.trim());
                  }
                }),
          ),
          bottom: TabBar(
            controller: tabController,
            isScrollable: true,
            indicatorColor: Colors.white,
            unselectedLabelColor: Colors.white60, // unselected color
            labelColor: Colors.blue, // selected color
            tabs: categories
                .map((category) => Tab(
                      text: category,
                    ))
                .toList(),
            onTap: (index) {
              final selectedCategory = categories[index];
              context.read<Searchscreencontroller>().onSearch(selectedCategory);
            },
          )),
      body: SafeArea(
        child: Column(
          children: [
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
