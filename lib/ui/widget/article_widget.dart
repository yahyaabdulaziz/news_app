import 'package:flutter/material.dart';
import 'package:news_app/model/articles_response.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ArticleWidget extends StatelessWidget {
  final Article article;

  const ArticleWidget({super.key, required this.article});

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: article.urlToImage ?? "",
              placeholder: (_, __) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (_, __, ___) => Icon(Icons.error),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 10, top: 6, bottom: 4),
            child: Text(
              article.source?.name ?? "",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          Text(article.title ?? ""),
          Container(
            margin: const EdgeInsets.only(right: 10, top: 4, bottom: 10),
            child: Text(
              article.publishedAt ?? "",
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
