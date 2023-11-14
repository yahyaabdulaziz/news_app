import 'package:flutter/material.dart';
import 'package:news_app/ui/screens/splash/splash_screen.dart';
import 'ui/screens/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return (MaterialApp(
      routes: {
        HomeScreen.routeName: (_) => HomeScreen(),
        SplashScreen.routeName: (_) => SplashScreen(),
      },
      initialRoute: HomeScreen.routeName,
    ));
  }
}
