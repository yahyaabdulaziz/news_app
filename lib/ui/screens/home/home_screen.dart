import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/data/api/api_manger.dart';
import 'package:news_app/model/CategoryDM.dart';
import 'package:news_app/model/articles_response.dart';
import 'package:news_app/provider/article_provider.dart';
import 'package:news_app/ui/screens/fav_articles/fav_articles.dart';
import 'package:news_app/ui/screens/home/tabs/catigerioes/categories_tab.dart';
import 'package:news_app/ui/screens/home/tabs/news/news_tab/news_tab.dart';
import 'package:news_app/ui/widget/article_widget.dart';
import 'package:news_app/ui/widget/error_view.dart';
import 'package:news_app/ui/widget/loading_view.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "HomeScreen";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Widget currentTab;
  late Orientation currentOrientation;

  @override
  void initState() {
    super.initState();
    // Avoid accessing inherited widgets in initState
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    currentTab = CategoriesTab(onCategoryClick);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (currentTab is! CategoriesTab) {
          currentTab = CategoriesTab(onCategoryClick);
          setState(() {});
          return false;
        } else {
          return true;
        }
      },
      child: ChangeNotifierProvider(
        create: (context) => ArticleProvider(),
        child: Scaffold(
          appBar: buildAppBar(),
          body: currentTab,
          drawer: buildDrawer(),
        ),
      ),
    );
  }

  onCategoryClick(CategoryDM categoryDM) {
    currentTab = NewsTab(categoryDM.id);
    setState(() {});
  }

  buildDrawer() {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.white,
            ), //BoxDecoration
            child: UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.white),
              accountName: const Text(
                "Yahya Abdelaziz",
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              accountEmail: const Text(
                "yahya@gmail.com",
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
              currentAccountPictureSize: const Size.square(45),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.grey.shade300,
                child: const Text(
                  "Y",
                  style: TextStyle(fontSize: 30.0, color: Colors.blue),
                ), //Text
              ), //circleAvatar
            ), //UserAccountDrawerHeader
          ), //DrawerHeader
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text(' My Profile '),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text(' My Favourite Articles '),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, ArticleScreen.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Exit App'),
            onTap: () {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            },
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget buildAppBar() {
    return AppBar(
      toolbarHeight: MediaQuery.of(context).size.height * .12,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
      ),
      backgroundColor: Colors.grey,
      title: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          child: const Text(
            "News App",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      actions: currentTab is NewsTab
          ? [
              IconButton(
                  onPressed: () {
                    showSearch(context: context, delegate: NewsDelegate());
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ))
            ]
          : null,
    );
  }
}

class NewsDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return const Icon(
      Icons.search_outlined,
      size: 28,
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
        appBarTheme: AppBarTheme(
            toolbarHeight: MediaQuery.of(context).size.height * .12,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12)),
            ),
            backgroundColor: Colors.grey));
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
        future: ApiManger.getArticles(query: query),
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

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Text("");
  }
}
