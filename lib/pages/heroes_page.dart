import 'package:flutter/material.dart';
import 'package:trilhaapp/model/characters_model.dart';
import 'package:trilhaapp/repositores/marvel/marvel_repository.dart';

class HerosPage extends StatefulWidget {
  const HerosPage({super.key});

  @override
  State<HerosPage> createState() => _HerosPageState();
}

class _HerosPageState extends State<HerosPage> {

  late MarvelRepository marvelRepository;
  CharactersModel charactersModel = CharactersModel();
  var offset = 0;
  ScrollController _scrollController = ScrollController();
  bool carregando = false;

  @override
  void initState() {
    super.initState();
    marvelRepository = MarvelRepository();
    getApiMarvel();

    _scrollController.addListener(() {
      print('pixels atual: ${_scrollController.position.pixels}');
      print('pixels max: ${_scrollController.position.maxScrollExtent}');

      var posicaoPaginacao = _scrollController.position.maxScrollExtent * 0.85;
      if (_scrollController.position.pixels > posicaoPaginacao) {
        print('Carregando página');
        getApiMarvel();
      }

    });
  }

  getApiMarvel() async {

    if(carregando) return;

    setState(() {
      carregando = true;
    });

    if(charactersModel.data == null || charactersModel.data!.results == null) {
      charactersModel = await marvelRepository.getCharacters(offset);
    } else {

      offset = offset + charactersModel.data!.count!;
      var tempList = await marvelRepository.getCharacters(offset);
      charactersModel.data!.results!.addAll(tempList.data!.results!);

    }

    carregando = false;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: carregando ? const Text('Carregando...') : const Text('Hérois')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: (
                  (charactersModel.data == null || charactersModel.data!.results == null ? 0 : charactersModel.data!.results!.length)
              ),
              itemBuilder: (_, int index) {
                var character = charactersModel.data!.results![index];

                return Card(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.network('${character.thumbnail!.path!}.${character.
                      thumbnail!.extension!}', width: 100,),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              character.name!,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                              )
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                              child: Text(
                                character.description!,
                                textAlign: TextAlign.justify,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            )
          ),
          carregando ? CircularProgressIndicator() : ElevatedButton(
            onPressed: () {
              getApiMarvel();
            },
            child: const Text('Carregar mais itens'))
        ],
      ),
    ));
  }
}
