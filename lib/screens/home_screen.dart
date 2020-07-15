import 'package:flutter/material.dart';
import 'package:fluttertube/delegades/data_search.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 70,
          child: Image.asset("images/youtube-logo-light.png"),
        ),
        elevation: 0,
        backgroundColor: Colors.black,
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Text("0"),
          ),
          IconButton(
              icon: Icon(
                Icons.star,
              ),
              onPressed: () {}),
          IconButton(
              icon: Icon(
                Icons.search,
              ),
              onPressed: () async {
                // Cria uma tela de pesquisa com um input a para inserir texto
                String result =
                    await showSearch(context: context, delegate: DataSearch());
                print(result);
              }),
        ],
      ),
      body: Container(),
    );
  }
}
