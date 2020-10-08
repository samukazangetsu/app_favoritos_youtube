import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:fluttertube/api.dart';
import 'package:fluttertube/models/video_model.dart';

class VideosBloc implements BlocBase {
  Api api;
  List<Video> videos;

  final _videosController = StreamController<List<Video>>();

  final _searchController = StreamController<String>();

  // Entrada da Stream (recebe dados de fora)
  Sink get inSearch => _searchController.sink;

  // Declarar um getter para ser acessível fora da classe
  Stream get outVideos => _videosController.stream;

  VideosBloc() {
    api = Api();

    // Chama a função _search sempre que o _searchController receber um novo dado
    _searchController.stream.listen(_search);
  }

  void _search(String search) async {
    if (search != null) {
      _videosController.add([]);
      videos = await api.search(search);
    } else {
      videos += await api.nextPage();
    }
    _videosController.sink.add(videos);
  }

  @override
  void addListener(listener) {}

  @override
  void dispose() {
    _videosController.close();
    _searchController.close();
  }

  @override
  bool get hasListeners => throw UnimplementedError();

  @override
  void notifyListeners() {}

  @override
  void removeListener(listener) {}
}
