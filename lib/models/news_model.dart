class CategoryModel {
  String? categoryName;

  CategoryModel({this.categoryName});
}

class NewsModel {
  final String? title;
  final String? description;
  final String? content;
  final String? url;
  final String? urlToImage;
  final String? author;

  NewsModel({
    this.title,
    this.description,
    this.content,
    this.url,
    this.urlToImage,
    this.author,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      title: json['title'],
      description: json['description'],
      content: json['content'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      author: json['author'],
    );
  }

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "content": content,
    "url": url,
    "urlToImage": urlToImage,
    "author": author,
  };
}
