import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ntgtask/constants/utils.dart';
import 'package:ntgtask/models/article_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleWidget extends StatelessWidget {
  const ArticleWidget({Key? key, required this.article}) : super(key: key);
  final Article article;
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            leading: const Icon(Icons.arrow_drop_down_circle),
            title: Text(article.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: GoogleFonts.poppins()),
            subtitle: Text(
              article.publishedAt,
              style: GoogleFonts.poppins(
                  color: Colors.black.withOpacity(0.6), fontSize: 12),
            ),
          ),
          CachedNetworkImage(
            imageUrl: article.urlToImage,
            errorWidget: (context, url, error) => Image.asset(
              "assets/image-not-found.jpg",
              height: 150,
              fit: BoxFit.fill,
            ),
            height: 150,
            fit: BoxFit.fill,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: RichText(
              text: TextSpan(
                  text: 'Source : ',
                  style: GoogleFonts.poppins(
                      color: Colors.black, fontWeight: FontWeight.w500),
                  children: [
                    TextSpan(
                      text: article.source.name,
                      style: GoogleFonts.poppins(
                          color: Colors.black.withOpacity(0.6)),
                    )
                  ]),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                onPressed: () => _launchUrl(article.url, context),
                child: const Text(
                  'Read More..',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(url, BuildContext context) async {
    if (!await launchUrl(Uri.parse(url))) {
      showSnackBar(context, 'Something went wrong please try again');
    }
  }
}
