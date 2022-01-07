import 'dart:convert';

class Movie {
  Movie({
    required this.adult,
    this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    this.posterPath,
    this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });
  bool adult;
  String? backdropPath;
  List<int> genreIds;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String? posterPath;
  String? releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  get fullPosterImg{
    if(this.posterPath == null) return 'https://i.stack.imgur.com/GNhxO.png';
    return 'https://image.tmdb.org/t/p/w500${this.posterPath}';
  }

  get fulBackdropPath{
    if(this.posterPath == null) return 'https://i.stack.imgur.com/GNhxO.png';
    return 'https://image.tmdb.org/t/p/w500${this.backdropPath}';
  }

  factory Movie.fromJson(String str) => Movie.fromMap(json.decode(str));//este factory Movie.fromJson viene el json.decode del string que le estoy mandando

  factory Movie.fromMap(Map<String, dynamic> json) => Movie(//hacemos el mapeo crecibe un mapa que se llama json y esta tomando cada una de las instacias y se las asigna a cada propiedad de la clase
    adult: json["adult"],
    backdropPath: json["backdrop_path"],
    genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
    id: json["id"],
    originalLanguage: json["original_language"],
    originalTitle: json["original_title"],
    overview: json["overview"],
    popularity: json["popularity"].toDouble(),
    posterPath: json["poster_path"],
    releaseDate: json["release_date"],
    title: json["title"],
    video: json["video"],
    voteAverage: json["vote_average"].toDouble(),
    voteCount: json["vote_count"],
  );
}