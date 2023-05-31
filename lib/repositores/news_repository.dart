import '../model/news.dart';
import '../shared/widgets/text_lorem_ipsum.dart';

class NewsRepository {

  Future<News> get() async {
    await Future.delayed(const Duration(seconds: 5));
    return News(
        1,
        "Meu APP",
        "https://hermes.digitalinnovation.one/assets/diome/logo.png",
        TextLoremIpsum().returnText(null)
    );
  }


}