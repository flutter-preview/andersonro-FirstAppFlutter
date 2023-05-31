import 'package:flutter/material.dart';

import '../model/news.dart';

class CardDetailPage extends StatelessWidget {
  final News news;

  const CardDetailPage({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: news.id,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(title: Text(news.title)),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                margin: const EdgeInsets.only(top: 8),
                width: double.infinity,
                child: Image.network(
                  news.urlImage,
                  height: 80,
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 18),
                  child: Text(
                    news.description,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
