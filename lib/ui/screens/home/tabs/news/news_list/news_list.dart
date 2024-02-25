import 'package:flutter/material.dart';
import 'package:news_app/data/api/api_manger.dart';
import 'package:news_app/model/articles_response.dart';
import 'package:news_app/ui/widget/article_widget.dart';

class NewsList extends StatefulWidget {
  final String sourceId;

  const NewsList({Key? key, required this.sourceId}) : super(key: key);

  @override
  NewsListState createState() => NewsListState();
}

class NewsListState extends State<NewsList> {
  List<Article> articles = [];
  int page = 1;
  bool isLoading = false;
  int itemsPerPage = 3;

  @override
  void initState() {
    super.initState();
    loadInitialArticles();
  }

  Future<void> loadInitialArticles() async {
    setState(() {
      isLoading = true;
    });

    try {
      final initialArticles = await ApiManger.getArticles(
        sourceId: widget.sourceId,
        page: page,
        pageSize: itemsPerPage,
      );

      setState(() {
        articles.addAll(initialArticles);
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      print('Error loading initial articles: $error');
    }
  }

  Future<void> loadMoreArticles() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      try {
        final moreArticles = await ApiManger.getArticles(
          sourceId: widget.sourceId,
          page: page,
          pageSize: itemsPerPage,
        );

        setState(() {
          articles.addAll(moreArticles);
          isLoading = false;
        });
      } catch (error) {
        setState(() {
          isLoading = false;
        });
        print('Error loading more articles: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        if (!isLoading &&
            scrollNotification is ScrollEndNotification &&
            scrollNotification.metrics.extentAfter == 0) {
          setState(() {
            isLoading = true;
            page++;
          });
          loadMoreArticles().then((_) {
            setState(() {
              isLoading = false;
            });
          });
        }
        return false;
      },
      child: ListView.builder(
        itemCount: articles.length + 1,
        itemBuilder: (context, index) {
          if (index < articles.length) {
            return ArticleWidget(
              article: articles[index],
            );
          } else if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
