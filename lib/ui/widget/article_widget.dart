import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/model/articles_response.dart';
import 'package:news_app/model/cart_item.dart';
import 'package:news_app/notification/notification_service.dart';
import 'package:news_app/provider/article_provider.dart';
import 'package:news_app/ui/screens/details_screen/details_screen.dart';
import 'package:provider/provider.dart';

class ArticleWidget extends StatefulWidget {
  final Article article;

  const ArticleWidget({Key? key, required this.article}) : super(key: key);

  @override
  ArticleWidgetState createState() => ArticleWidgetState();
}

class ArticleWidgetState extends State<ArticleWidget> {
  bool isPressed = true;
  late ArticleProvider provider;

  Widget _buildPortraitLayout(BoxConstraints constraints) {
    provider = Provider.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CachedNetworkImage(
            imageUrl: widget.article.urlToImage ?? "",
            placeholder: (_, __) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (_, __, ___) => const Icon(Icons.error),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 10),
          child: Row(
            children: [
              Text(
                widget.article.source?.name ?? "",
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () async {
                  if (isPressed) {
                    // Add the item to Firebase
                    ArticleItem item = ArticleItem(
                      image: widget.article.urlToImage ?? "",
                      title: widget.article.source?.name ?? "",
                      description: widget.article.title ?? "",
                    );
                    await provider.addToCart(item);
                  } else {
                    // remove the item from Firebase
                    String articleTitle = widget.article.title ?? "";
                    if (articleTitle.isNotEmpty) {
                      try {
                        await provider.removeFromCart(articleTitle);
                        print(articleTitle);
                        print('Item removed from cart successfully');
                      } catch (error) {
                        print('Error removing item from cart: $error');
                      }
                    } else {
                      print('Article URL is empty');
                    }
                  }

                  setState(() {
                    isPressed = !isPressed;
                  });

                  await NotificationService().showNotification(
                    title:
                        "${widget.article.source?.name} is ${isPressed ? 'removed from' : 'added to'} your Fav",
                    body: widget.article.title,
                  );
                },
                icon: isPressed
                    ? const Icon(
                        Icons.favorite_border,
                        size: 30,
                        color: Colors.black,
                      )
                    : const Icon(
                        Icons.favorite,
                        size: 30,
                        color: Colors.black,
                      ),
              ),
            ],
          ),
        ),
        Text(widget.article.title ?? ""),
        Container(
          margin: const EdgeInsets.only(right: 10, top: 4, bottom: 10),
          child: Text(
            widget.article.publishedAt ?? "",
            textAlign: TextAlign.end,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildLandscapeLayout(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.height * .35,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: widget.article.urlToImage ?? "",
              placeholder: (_, __) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (_, __, ___) => const Icon(Icons.error),
            ),
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Text(
                    widget.article.source?.name ?? "",
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () async {
                      final articleProvider =
                          Provider.of<ArticleProvider>(context, listen: false);

                      if (isPressed) {
                        // Add the item to Firebase
                        ArticleItem item = ArticleItem(
                          image: widget.article.urlToImage ?? "",
                          title: widget.article.source?.name ?? "",
                          description: widget.article.title ?? "",
                        );
                        await articleProvider.addToCart(item);
                      } else {
                        // Remove the item from Firebase
                        String articleTitle = widget.article.title ?? "";
                        if (articleTitle.isNotEmpty) {
                          try {
                            await articleProvider.removeFromCart(articleTitle);
                            print(articleTitle);
                            print('Item removed from cart successfully');
                          } catch (error) {
                            print('Error removing item from cart: $error');
                          }
                        } else {
                          print('Article URL is empty');
                        }
                      }

                      setState(() {
                        isPressed = !isPressed;
                      });

                      await NotificationService().showNotification(
                        title:
                            "${widget.article.source?.name} is ${isPressed ? 'removed from' : 'added to'} your Fav",
                        body: widget.article.title,
                      );
                    },
                    icon: isPressed
                        ? const Icon(
                            Icons.favorite_border,
                            size: 30,
                            color: Colors.black,
                          )
                        : const Icon(
                            Icons.favorite,
                            size: 30,
                            color: Colors.black,
                          ),
                  ),
                ],
              ),
              Text(
                widget.article.title ?? "",
                textAlign: TextAlign.start,
              ),
              Row(
                children: [
                  const Spacer(),
                  Container(
                    margin:
                        const EdgeInsets.only(right: 10, top: 4, bottom: 10),
                    child: Text(
                      widget.article.publishedAt ?? "",
                      textAlign: TextAlign.end,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  @override
  void initState() {
    NotificationService().initNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, DetailsScreen.routeName,
            arguments: widget.article);
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          return OrientationBuilder(
            builder: (context, orientation) {
              return Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.shade200,
                  border: Border.all(width: 2),
                ),
                child: orientation == Orientation.landscape
                    ? _buildLandscapeLayout(constraints)
                    : _buildPortraitLayout(constraints),
              );
            },
          );
        },
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }
}
