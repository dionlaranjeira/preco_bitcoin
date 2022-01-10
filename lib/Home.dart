import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var _preco = "";

  void obterPreco() async{
    var url = "https://www.blockchain.com/ticker";
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.getUrl(Uri.parse(url));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();

    Map<String, dynamic> respostaMap = json.decode(reply);

    _preco =  "R\$ " + respostaMap["BRL"]["buy"].toString().replaceAll(".", ",");
    setState(() {
      _preco;
    });

  }

  @override
  Widget build(BuildContext context) {
    obterPreco();
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("images/bitcoin.png"),
            Text(
                _preco,
                style: TextStyle(
                  color: Colors.black,
                  decoration: TextDecoration.none,
                  fontSize: 24,
                ),
            ),
            ElevatedButton(
                onPressed: obterPreco,
                child: Text("ATUALIZAR"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.amber,
                  padding: EdgeInsets.all(18),
                  textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

            ),
          ],
        ),
      ),
    );
  }
}
