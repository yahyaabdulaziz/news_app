import 'package:flutter/material.dart';
import 'package:news_app/ui/screens/home/tabs/news/news_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "HomeScreen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: NewsTab(),
    );
  }

  PreferredSizeWidget buildAppBar() {
    return AppBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
      ),
      backgroundColor: Colors.green,
      leading: const Icon(Icons.menu_sharp, color: Colors.white),
      title: const Expanded(
          child: Center(
        child: Text(
          "News App",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
      )),
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
