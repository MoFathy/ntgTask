import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ntgtask/constants/error_handling.dart';
import 'package:ntgtask/constants/global_variables.dart';
import 'package:ntgtask/constants/utils.dart';
import 'package:http/http.dart' as http;
import 'package:ntgtask/providers/articles_provider.dart';
import 'package:provider/provider.dart';

class NewsServices {
  Future<void> fetchArticles({required BuildContext context}) async {
    var pageNumber = context.read<ArticlesProvider>().pageToFetch;

    try {
      http.Response res = await http.get(
        Uri.parse('$apiUrl&page=$pageNumber&pageSize=10'),
      );
      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () {
          Provider.of<ArticlesProvider>(context, listen: false)
              .setArticles(jsonEncode(jsonDecode(utf8.decode(res.bodyBytes))));
        },
      );
    } catch (e) {
      Provider.of<ArticlesProvider>(context, listen: false).setIsError(true);
      showSnackBar(context, "Something went wrong, please try again later");
    }
  }
}
