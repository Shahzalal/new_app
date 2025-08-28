import 'dart:convert';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import '../models/news_model.dart';

class NewsApiService {
  final String _apiKey = "ba7fb40dd74e456fa756c98e47713725";
  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 80,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
  );

  /// Fetch news from API
  Future<List<NewsModel>> getNews() async {
    List<NewsModel> newsList = [];

    try {
      Uri uri = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=$_apiKey",
      );

      final Response response = await get(uri);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        if (responseBody["status"] == 'ok') {
          List articles = responseBody["articles"];

          // Filter articles with required fields and convert to NewsModel
          newsList = articles
              .where((article) =>
          article["urlToImage"] != null &&
              article["description"] != null &&
              article["author"] != null &&
              article["content"] != null)
              .map((article) => NewsModel.fromJson(article))
              .toList();

          // Logger debug
          for (var article in newsList) {
            _logger.i(article.toJson());
          }
        } else {
          _logger.w("API returned status: ${responseBody["status"]}");
        }
      } else {
        _logger.e("Failed to fetch news. Status code: ${response.statusCode}");
      }
    } catch (e) {
      _logger.e("Error fetching news: $e");
    }

    return newsList;
  }
}
class CategoryApiService {
  final String _apiKey = "ba7fb40dd74e456fa756c98e47713725";
  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 80,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
  );

  /// Fetch news from API
  Future<List<NewsModel>> getCategory(String category) async {
    List<NewsModel> newsList = [];

    try {
      Uri uri = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=$_apiKey",
      );

      final Response response = await get(uri);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        if (responseBody["status"] == 'ok') {
          List articles = responseBody["articles"];

          // Filter articles with required fields and convert to NewsModel
          newsList = articles
              .where((article) =>
          article["urlToImage"] != null &&
              article["description"] != null &&
              article["author"] != null &&
              article["content"] != null)
              .map((article) => NewsModel.fromJson(article))
              .toList();

          // Logger debug
          for (var article in newsList) {
            _logger.i(article.toJson());
          }
        } else {
          _logger.w("API returned status: ${responseBody["status"]}");
        }
      } else {
        _logger.e("Failed to fetch news. Status code: ${response.statusCode}");
      }
    } catch (e) {
      _logger.e("Error fetching news: $e");
    }

    return newsList;
  }
}