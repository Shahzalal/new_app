import 'package:flutter/material.dart';
import 'package:news_app/app/size_config.dart';
import 'package:news_app/models/news_model.dart';

class NewsDetails extends StatelessWidget {
  const NewsDetails({super.key, required this.newsModel});

  final NewsModel newsModel;

  @override
  Widget build(BuildContext context) {
    // 🔹 initialize SizeConfig
    SizeConfig.init(context);

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: SizeConfig.fs(18),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.ws(16),
          vertical: SizeConfig.hs(8),
        ),
        child: ListView(
          children: [
            // Title
            Text(
              newsModel.title ?? "No Title",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.fs(20),
              ),
            ),
            SizedBox(height: SizeConfig.hs(6)),

            // Author
            Row(
              children: [
                Expanded(child: SizedBox()),
                Expanded(
                  // Author
                  child: Align(
                    alignment: Alignment.centerRight, // bottom-right নয়, শুধু right
                    child: Text(
                      "- ${newsModel.author ?? "Unknown"}",
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: SizeConfig.fs(14),
                        color: Colors.grey[700],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),


                ),
              ],
            ),
            SizedBox(height: SizeConfig.hs(16)),

            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(SizeConfig.ws(10)),
              child: newsModel.urlToImage != null
                  ? Image.network(
                newsModel.urlToImage!,
                width: double.infinity,
                height: SizeConfig.hs(200),
                fit: BoxFit.cover,
              )
                  : Container(
                width: double.infinity,
                height: SizeConfig.hs(200),
                color: Colors.grey[300],
                child: Icon(
                  Icons.image,
                  size: SizeConfig.fs(40),
                  color: Colors.grey[600],
                ),
              ),
            ),
            SizedBox(height: SizeConfig.hs(16)),

            // Content
            Text(
              newsModel.content ?? "No Content",
              style: TextStyle(
                fontSize: SizeConfig.fs(16),
              ),
            ),
            SizedBox(height: SizeConfig.hs(8)),

            // Description
            Text(
              newsModel.description ?? "No Description",
              style: TextStyle(
                fontSize: SizeConfig.fs(16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
