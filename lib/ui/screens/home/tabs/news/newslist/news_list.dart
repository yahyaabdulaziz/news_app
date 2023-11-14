import 'package:flutter/material.dart';
import 'package:news_app/data/api/api_manger.dart';
import 'package:news_app/model/articles_response.dart';
import 'package:news_app/ui/widget/article_widget.dart';
import 'package:news_app/ui/widget/error_view.dart';
import 'package:news_app/ui/widget/loading_view.dart';

class NewsList extends StatelessWidget {
  final String sourceId;

  const NewsList({super.key, required this.sourceId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ApiManger.getArticles(sourceId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return buildArticlesListView(snapshot.data!);
          } else if (snapshot.hasError) {
            return ErrorView(message: snapshot.error.toString());
          } else {
            return const Center(child: LoadingView());
          }
        });
  }

  buildArticlesListView(List<Article> articles) {
    return ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          return ArticleWidget(
            article: articles[index],
          );
        });
  }
}
