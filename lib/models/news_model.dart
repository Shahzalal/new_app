class CategoryModel {
  String? categoryName;

  CategoryModel({this.categoryName});
}

class NewsModel {
  String? title;
  String? description;
  String? urlToImage;
  String? author;
  String? content;

  NewsModel({
    this.title,
    this.description,
    this.urlToImage,
    this.author,
    this.content,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      title: json['title'],
      description: json['description'],
      urlToImage: json['urlToImage'],
      author: json['author'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'urlToImage': urlToImage,
      'author': author,
      'content': content,
    };
  }
}

