// To parse this JSON data, do
//
//     final nowPlayingResponse = nowPlayingResponseFromMap(jsonString);

import 'dart:convert';

import 'models.dart';

class NowPlayingResponse {

  NowPlayingResponse({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  Dates dates;
  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  factory NowPlayingResponse.fromJson(String str) => NowPlayingResponse.fromMap(json.decode(str));
  //NowPlayingResponse.fromJson recibe un string y crea una instancia de
  //NowPlayingResponse.fromMap basado en un json que está recibiendo (trae toda la información mapeada que necesito)

  factory NowPlayingResponse.fromMap(Map<String, dynamic> json) => NowPlayingResponse(//Es el metodo que se está llamando arriba (factory constructor) que recibe un mapa que se llama json
    //Luego crea una instancia las cuales toma las fechas, pages, etc los mapea
    dates: Dates.fromMap(json["dates"]),
    page: json["page"],
    results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))
      /*
      *creo un listado de Movie basados en los resultados del from()
      * json["results"].map((x) de esto hago un ciclo interno
      * parar crear instancias independientes de movie
       */
    ),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );
}

class Dates {
  Dates({
    required this.maximum,
    required this.minimum,
  });

  DateTime maximum;
  DateTime minimum;

  factory Dates.fromJson(String str) => Dates.fromMap(json.decode(str));

  factory Dates.fromMap(Map<String, dynamic> json) => Dates(
    maximum: DateTime.parse(json["maximum"]),
    minimum: DateTime.parse(json["minimum"]),
  );

}