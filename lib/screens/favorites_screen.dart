import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:fluttertube/blocs/favorite_bloc.dart';
import 'package:fluttertube/models/video_model.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final blocFavorites = BlocProvider.getBloc<FavoriteBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Favoritos"),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.black87,
      body: StreamBuilder<Map<String, Video>>(
        initialData: {},
        stream: blocFavorites.outFav,
        builder: (context, snapshot) {
          return ListView(
            children: snapshot.data.values.map((v) {
              return InkWell(
                onTap: () {},
                onLongPress: () {
                  blocFavorites.toggleFavorite(v);
                },
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      height: 50,
                      child: Image.network(v.thumb),
                    ),
                    Expanded(
                        child: Text(
                      v.title,
                      style: TextStyle(color: Colors.white70),
                      maxLines: 2,
                    ))
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
