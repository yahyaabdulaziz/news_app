import 'package:flutter/material.dart';
import 'package:news_app/model/CategoryDM.dart';
import 'package:news_app/ui/screens/home/tabs/catigerioes/categories_tab.dart';
import 'package:news_app/ui/screens/home/tabs/news/news_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Widget currentTab;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
      child: Scaffold(
        appBar: buildAppBar(),
        body: currentTab,
      ),
    );
  }

  onCategoryClick(CategoryDM categoryDM) {
    currentTab = NewsTab(categoryDM.id);
    setState(() {});
  }

  PreferredSizeWidget buildAppBar() {
    return AppBar(
      toolbarHeight: MediaQuery.of(context).size.height * .10,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
      ),
      backgroundColor: Colors.green,
      leading: const Icon(Icons.menu_sharp, color: Colors.white),
      title: Center(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 12),
          child: const Text(
            "News App",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {},
            child: const Icon(
              Icons.search,
              color: Colors.white,
            ))
      ],
    );
  }
}
