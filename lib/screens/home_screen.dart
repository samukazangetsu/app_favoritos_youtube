import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:fluttertube/blocs/favorite_bloc.dart';
import 'package:fluttertube/blocs/videos_bloc.dart';
import 'package:fluttertube/delegades/data_search.dart';
import 'package:fluttertube/models/video_model.dart';
import 'package:fluttertube/screens/favorites_screen.dart';
import 'package:fluttertube/widgets/video_tile.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final blocVideos = BlocProvider.getBloc<VideosBloc>();
    final blocFavorites = BlocProvider.getBloc<FavoriteBloc>();

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
            child: StreamBuilder<Map<String, Video>>(
                stream: blocFavorites.outFav,
                builder: (context, snapshot) {
                  if (snapshot.hasData)
                    return Text("${snapshot.data.length}");
                  else
                    return Container();
                }),
          ),
          IconButton(
              icon: Icon(
                Icons.star,
              ),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => FavoritesScreen()));
              }),
          IconButton(
              icon: Icon(
                Icons.search,
              ),
              onPressed: () async {
                // Cria uma tela de pesquisa com um input a para inserir texto
                String result =
                    await showSearch(context: context, delegate: DataSearch());
                if (result != null) blocVideos.inSearch.add(result);
              }),
        ],
      ),
      backgroundColor: Colors.black87,
      body: StreamBuilder(
          stream: blocVideos.outVideos,
          initialData: [],
          builder: (context, snapshot) {
            if (snapshot.hasData)
              return ListView.builder(
                itemBuilder: (context, index) {
                  print(snapshot.data);
                  if (index < snapshot.data.length) {
                    return VideoTile(snapshot.data[index]);
                  } else if (index > 1) {
                    blocVideos.inSearch.add(null);
                    return Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
                itemCount: snapshot.data.length + 1,
              );
            else {
              print("sem dados");
              return Container();
            }
          }),
    );
  }
}
