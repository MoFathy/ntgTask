import 'package:flutter/material.dart';
import 'package:ntgtask/models/article_model.dart';
import 'package:ntgtask/models/news_response.dart';

class ArticlesProvider extends ChangeNotifier {
  final List<Article> _articles = [];
  bool _isLastPage = false;
  bool _isError = false;
  int _pageToFetch = 1;

  List<Article> get articles => _articles;
  bool get isLastPage => _isLastPage;
  bool get isError => _isError;
  int get pageToFetch => _pageToFetch;

  void setArticles(String newsResponse) {
    List<Article> responseArticle =
        NewsResponse.fromJson(newsResponse).articles;
    int totalResults = NewsResponse.fromJson(newsResponse).totalResults;

    _articles.addAll(responseArticle);
    _isError = false;
    _pageToFetch++;
    if (_articles.length >= totalResults) {
      _isLastPage = true;
    }
    notifyListeners();
  }

  void setIsError(bool isErr) {
    _isError = isErr;
    notifyListeners();
  }
}
