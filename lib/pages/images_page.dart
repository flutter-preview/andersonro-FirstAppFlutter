import 'package:flutter/material.dart';
import 'package:trilhaapp/shared/widgets/app_images.dart';

class ImagensPage extends StatefulWidget {
  const ImagensPage({Key? key}) : super(key: key);

  @override
  State<ImagensPage> createState() => _ImagensPageState();
}

class _ImagensPageState extends State<ImagensPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(AppImagens.Icone1, height: 50,),
        Image.asset(AppImagens.Icone2, height: 50,),
        Image.asset(AppImagens.Icone3, height: 50,),
        Image.asset(AppImagens.Icone4, height: 50,),
      ],
    );
  }
}
