import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TesteHttpPage extends StatefulWidget {
  const TesteHttpPage({super.key});

  @override
  State<TesteHttpPage> createState() => _TesteHttpPageState();
}

class _TesteHttpPageState extends State<TesteHttpPage> {

  void getHttp() async {
    debugPrint('Init Http');
    var url = "https://www.google.com";
    var response = await http.get(Uri.parse(url));
    debugPrint(response.statusCode.toString());
    debugPrint(response.headers.toString());
    debugPrint(response.body.toString());
    
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Container(),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            getHttp();
          }
      ),
    ));
  }
}
