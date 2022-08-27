import 'dart:convert';

import 'package:ntgtask/models/article_model.dart';

class NewsResponse {
  String status;
  int totalResults;
  List<Article> articles;
  NewsResponse({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'totalResults': totalResults,
      'articles': articles.map((x) => x.toMap()).toList(),
    };
  }

  factory NewsResponse.fromMap(Map<String, dynamic> map) {
    return NewsResponse(
      status: map['status'] ?? '',
      totalResults: map['totalResults']?.toInt() ?? 0,
      articles:
          List<Article>.from(map['articles']?.map((x) => Article.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory NewsResponse.fromJson(String source) =>
      NewsResponse.fromMap(json.decode(source));
}
