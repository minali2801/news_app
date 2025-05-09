class Article {
  final String title;
  final String  description;
  final String urlToImage;
  final String  sourceName;
  final String publishedDate;
  final String url;

  Article({required this.title, required this.description, required this.urlToImage, required this.sourceName, required this.publishedDate,required this.url});

   factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      url: json['url'] ?? '',
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? 'No Description',
      urlToImage: json['urlToImage'] ?? '',
      sourceName: json['source'] != null && json['source']['name'] != null
          ? json['source']['name']
          : 'Unknown Source',
      publishedDate: json['publishedAt'] ?? '0',
    );
  }
}