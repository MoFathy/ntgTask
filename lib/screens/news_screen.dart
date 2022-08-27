import 'package:flutter/material.dart';
import 'package:ntgtask/models/article_model.dart';
import 'package:ntgtask/providers/articles_provider.dart';
import 'package:ntgtask/services/news_services.dart';
import 'package:ntgtask/widgets/article_widget.dart';
import 'package:ntgtask/widgets/error_dialogue.dart';
import 'package:provider/provider.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late bool _loading;
  final int _nextPageTrigger = 1;

  @override
  void initState() {
    super.initState();
    _loading = true;
    fetchData();
  }

  void fetchData() async {
    await NewsServices().fetchArticles(context: context);
    _loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var articles = context.watch<ArticlesProvider>().articles;
    var isLastPage = context.watch<ArticlesProvider>().isLastPage;
    var isError = context.watch<ArticlesProvider>().isError;
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
        ),
        body: buildArticlesView(articles, isLastPage, isError));
  }

  Widget buildArticlesView(
      List<Article> articles, bool isLastPage, bool isError) {
    if (articles.isEmpty) {
      if (_loading) {
        return const Center(
            child: Padding(
          padding: EdgeInsets.all(8),
          child: CircularProgressIndicator(),
        ));
      } else if (isError && articles.isEmpty) {
        return ErrorDialogue(size: 18, context: context);
      }
    }
    return ListView.builder(
        itemCount: articles.length + (isLastPage ? 0 : 1),
        itemBuilder: (context, index) {
          if (!isLastPage &&
              !isError &&
              index == articles.length - _nextPageTrigger) {
            fetchData();
          }
          if (index == articles.length) {
            if (isError) {
              return ErrorDialogue(size: 15, context: context);
            } else {
              return const Center(
                  child: Padding(
                padding: EdgeInsets.all(8),
                child: CircularProgressIndicator(),
              ));
            }
          }
          final Article article = articles[index];
          return Padding(
              padding: const EdgeInsets.all(15.0),
              child: ArticleWidget(article: article));
        });
  }
}
