import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/views/news_details.dart';
import 'package:news_app/views/selected_category_news.dart';
import '../models/category_data.dart';
import '../models/news_model.dart';
import '../services/services.dart';
import '../app/size_config.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<NewsModel> articles = [];
  List<CategoryModel> categories = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    categories = getCategories();
    getNews();
  }

  Future<void> getNews() async {
    NewsApiService newsApiService = NewsApiService();
    articles = await newsApiService.getNews();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Initialize SizeConfig
    SizeConfig.init(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'News',
              style: TextStyle(
                fontSize: SizeConfig.fs(20),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: SizeConfig.ws(4)),
            Text(
              'Apps',
              style: TextStyle(
                fontSize: SizeConfig.fs(20),
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Column(
                children: [
                  //for category selection
                  Container(
                    height: SizeConfig.hs(40),
                    margin: EdgeInsets.symmetric(horizontal: SizeConfig.ws(10)),
                    child: ListView.builder(
                      itemCount: categories.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return GestureDetector(
                          onTap: () {
                            // TODO: Navigate to details page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SelectedCategoryNews(
                                  category: category.categoryName!,
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: SizeConfig.ws(8),
                              bottom: SizeConfig.ws(3),
                            ),

                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  SizeConfig.ws(6),
                                ),
                                color: Colors.blue,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.ws(16),
                                vertical: SizeConfig.hs(8),
                              ),
                              child: Center(
                                child: Text(
                                  category.categoryName!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: SizeConfig.fs(15),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        final article = articles[index];
                        return GestureDetector(
                          onTap: () {
                            // TODO: Navigate to details page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    NewsDetails(newsModel: article),
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: SizeConfig.ws(10),
                              vertical: SizeConfig.hs(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Article Image with ternary
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    SizeConfig.ws(8),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: article.urlToImage ?? "",
                                    width: double.infinity,
                                    height: SizeConfig.hs(200),
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Container(
                                      color: Colors.grey[300],
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                          color: Colors.grey[300],
                                          child: Icon(
                                            Icons.image,
                                            size: SizeConfig.fs(40),
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                  ),
                                ),

                                SizedBox(height: SizeConfig.hs(8)),

                                // Article Title
                                Text(
                                  article.title ?? "No Title",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: SizeConfig.fs(18),
                                  ),
                                ),

                                SizedBox(height: SizeConfig.hs(4)),

                                // Divider
                                Divider(thickness: 2, color: Colors.grey[300]),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
