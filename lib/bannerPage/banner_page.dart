import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class BannerPage extends StatefulWidget {
  const BannerPage({
    Key? key,
    required this.image,
    required this.title,
    required this.date,
    required this.content,
    required this.pages,
  }) : super(key: key);

  final String
      image; 
  final String title; 
  final String date; 
  final String content;
  final String pages;
  @override
  State<BannerPage> createState() => _BannerPageState();
}

class _BannerPageState extends State<BannerPage> {
  bool expandido = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text('Material App Bar'),
            Spacer(),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.public),
            ),
            IconButton(
              onPressed: () {
                Share.share("the title is ${widget.title}\nThe pages are ${widget.pages}", subject: "Libro");
              },
              icon: Icon(Icons.share),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
              ),
              Image.network(widget.image),
              SizedBox(
                height: 30,
              ),
              Text(widget.title),
              SizedBox(
                height: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(widget.date),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        expandido = !expandido;
                        print(expandido);
                      });
                    },
                    child: Text(
                      widget.content,
                      textAlign: TextAlign.justify,
                      maxLines: (!expandido) ? 10 : 300000,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
