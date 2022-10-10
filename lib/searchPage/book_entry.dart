import 'package:flutter/material.dart';

import '../bannerPage/banner_page.dart';

class BookEntry extends StatelessWidget {
  const BookEntry({
    Key? key,
    required this.element,
  }) : super(key: key);

  final Map<String,String> element;

  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: () {
        _goToPage(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              element["image"]!,
              width: 100,
              height: 150,
              fit: BoxFit.cover
            ),
            Text(element["title"]!,
            maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }

  void _goToPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BannerPage(
          content: element["description"]!,
          date: element["date"]!,
          image: element["image"]!,
          title: element["title"]!,
          pages: element["pageCount"]!,
        ),
      ),
    );
  }
}
