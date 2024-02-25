import 'package:flutter/material.dart';
import 'package:news_app/model/cart_item.dart';
import 'package:news_app/provider/article_provider.dart';
import 'package:provider/provider.dart';

class ArticleScreen extends StatefulWidget {
  static const String routeName = "ArticleScreen";

  const ArticleScreen({super.key});

  @override
  ArticleScreenState createState() => ArticleScreenState();
}

class ArticleScreenState extends State<ArticleScreen> {
  List<ArticleItem> articleItems = [];
  late ArticleProvider provider;

  @override
  void initState() {
    super.initState();
    fetchCartItems();
  }

  Future<void> fetchCartItems() async {
    provider = Provider.of(context);
    List<ArticleItem> items = await provider.getCartItems();
    setState(() {
      articleItems = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite Articles'),
      ),
      body: ListView.builder(
        itemCount: articleItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.network(articleItems[index].image),
            title: Text(articleItems[index].title),
            subtitle: Text(articleItems[index].description),
          );
        },
      ),
    );
  }
}
