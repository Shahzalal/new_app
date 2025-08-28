import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/app/size_config.dart';
import '../models/news_model.dart';
import '../services/services.dart';
import 'news_details.dart';

class SelectedCategoryNews extends StatefulWidget {
  const SelectedCategoryNews({super.key, required this.category});

  final String category;

  @override
  State<SelectedCategoryNews> createState() => _SelectedCategoryNewsState();
}

class _SelectedCategoryNewsState extends State<SelectedCategoryNews> {
  List<NewsModel> articles = [];
  bool isLoading = true;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    getNews();
  }

  Future<void> getNews() async {
    try {
      CategoryApiService categoryApiService = CategoryApiService();
      articles = await categoryApiService.getCategory(widget.category);

      if (articles.isEmpty) {
        setState(() {
          isError = true;
        });
      }
    } catch (e) {
      setState(() {
        isError = true;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: Text(
          widget.category,
          style: TextStyle(color: Colors.white, fontSize: SizeConfig.fs(18)),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : isError
            ? Center(
                child: Text(
                  "Something went wrong or no data found",
                  style: TextStyle(fontSize: SizeConfig.fs(16)),
                  textAlign: TextAlign.center,
                ),
              )
            : ListView.builder(
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
                              errorWidget: (context, url, error) => Container(
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
    );
  }
}
