import 'package:flutter/material.dart';
import 'package:trilhaapp/model/news.dart';
import 'package:trilhaapp/pages/card_detail_page.dart';
import 'package:trilhaapp/repositores/news_repository.dart';
import 'package:trilhaapp/shared/widgets/text_lorem_ipsum.dart';

class CardPage extends StatefulWidget {
  const CardPage({Key? key}) : super(key: key);

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {

  News? news;
  NewsRepository newsRepository = NewsRepository();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    news = await newsRepository.get();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
             news == null ? const Center(child: CircularProgressIndicator()) : Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
              child: Card(
                elevation: 8,
                shadowColor: Colors.grey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.network(news!.urlImage, height: 30,),
                            Text(
                              news!.title,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        Text(
                          "${TextLoremIpsum().returnText(200)}...",
                          textAlign: TextAlign.justify,
                        ),
                        Container(
                          width: double.infinity,
                          alignment: Alignment.centerRight,
                          child: Hero(
                            tag: news!.id,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (BuildContext bc) => CardDetailPage(news: news!,))
                                );
                              },
                              child: const Text(
                                "Ler mais...",
                                style:
                                    TextStyle(decoration: TextDecoration.underline),
                              ),
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
