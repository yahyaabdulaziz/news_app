import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:news_app/ui/screens/article_webview/article_webview.dart';
import 'package:news_app/ui/screens/details_screen/details_screen.dart';
import 'package:news_app/ui/screens/fav_articles/fav_articles.dart';
import 'package:news_app/ui/screens/splash/splash_screen.dart';

import 'ui/screens/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return (MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routeName: (_) => const HomeScreen(),
        SplashScreen.routeName: (_) => const SplashScreen(),
        DetailsScreen.routeName: (_) => const DetailsScreen(),
        ArticleWebView.routeName: (_) => const ArticleWebView(),
        ArticleScreen.routeName: (_) => const ArticleScreen(),
      },
      initialRoute: SplashScreen.routeName,
    ));
  }
}
