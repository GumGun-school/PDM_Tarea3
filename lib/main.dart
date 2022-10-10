import 'package:book_library/bannerPage/banner_page.dart';
import 'package:book_library/searchPage/search_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Libreria free to play',
      theme: ThemeData(
          appBarTheme: AppBarTheme(
        color: Color.fromARGB(255, 29, 29, 29),
      )),
      home: SearchPage(),
    );
  }
}
