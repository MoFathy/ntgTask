import 'package:flutter/material.dart';
import 'package:ntgtask/providers/articles_provider.dart';
import 'package:ntgtask/screens/news_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NTG Task',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
          create: (context) => ArticlesProvider(),
          child: const NewsScreen(title: 'Latest News')),
      debugShowCheckedModeBanner: false,
    );
  }
}
