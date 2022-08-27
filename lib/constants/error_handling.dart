import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ntgtask/constants/utils.dart';

void httpErrorHandler(
    {required http.Response response,
    required BuildContext context,
    required VoidCallback onSuccess}) {
  switch (response.statusCode) {
    case 200:
      if (jsonDecode(response.body)['status'] == "ok") {
        onSuccess();
      } else {
        showSnackBar(
            context, jsonDecode(utf8.decode(response.bodyBytes))['message']);
      }
      break;
    case 400:
      showSnackBar(
          context, jsonDecode(utf8.decode(response.bodyBytes))['message']);
      break;
    case 500:
      showSnackBar(
          context, jsonDecode(utf8.decode(response.bodyBytes))['message']);
      break;
    default:
      showSnackBar(context, jsonDecode(utf8.decode(response.bodyBytes)));
  }
}
