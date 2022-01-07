import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/models.dart';

class MoviesProvider extends ChangeNotifier {

  String _baseUrl = 'api.themoviedb.org';
  String _apyKey = '82637c46c914fce186199356d2069efe';
  String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  Map<int, List<Cast>> movieCast = {};

  int _popularPage = 0;


  MoviesProvider() {
    print('HolA');
    getOnDisplayMovies();
    getPopularMovies();
  }

  Future<String>_getJsonData(String endPoint, [int page =1]) async{
    var url = Uri.https(_baseUrl, endPoint,
        {
          'api_key': _apyKey,
          'language': _language,
          'page': '$page'
        }
    );

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async{
    print('Metodo uno trae peliculas de ahora');
    final jsonData = await _getJsonData('3/movie/now_playing');
    final nowPlayingResponse = await NowPlayingResponse.fromJson(jsonData);
    //final Map<String, dynamic> decodedData = json.decode(response.body);
    //print(nowPlayingResponse.results[1].title);

    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {
    print('Metodo dos que trae peliculas populares');

    _popularPage ++;

    final jsonData = await _getJsonData('3/movie/popular', _popularPage);
    final popularResponse = await PopularsResponse.fromJson(jsonData);
    //final Map<String, dynamic> decodedData = json.decode(response.body);

    popularMovies = [...popularMovies, ...popularResponse.results];//para tener todos los resultados si se hace otra peticioon
    //igual tener los datos ya traidos antes
    //print(popularMovies[0].title);
    notifyListeners();
  }

  Future<List<Cast>>getMovieCast( int movieId ) async {

    if(movieCast.containsKey(movieId)) return movieCast[movieId]!;

    print('pidiendo info al servidor de los actores');
    final jsonData = await _getJsonData('3/movie/${movieId}/credits');
    final creditResponse = CreditsResponse.fromJson(jsonData);

    movieCast[movieId] = creditResponse.cast;

    return creditResponse.cast;
  }

}