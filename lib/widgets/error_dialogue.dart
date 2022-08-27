import 'package:flutter/material.dart';
import 'package:ntgtask/services/news_services.dart';

class ErrorDialogue extends StatelessWidget {
  final double size;
  final BuildContext context;
  const ErrorDialogue({Key? key, required this.size, required this.context})
      : super(key: key);

  void fetchData() async {
    await NewsServices().fetchArticles(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return errorDialog();
  }

  Widget errorDialog() {
    return Center(
      child: SizedBox(
        height: 180,
        width: 280,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'An error occurred when fetching the Articles.',
              style: TextStyle(
                  fontSize: size,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
                onPressed: () {
                  fetchData();
                },
                child: const Text(
                  "Retry",
                  style: TextStyle(fontSize: 20, color: Colors.purpleAccent),
                )),
          ],
        ),
      ),
    );
  }
}
