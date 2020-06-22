import 'package:flutter/material.dart';

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
              onPressed: () {}),
        ],
      ),
      body: Container(),
    );
  }
}
