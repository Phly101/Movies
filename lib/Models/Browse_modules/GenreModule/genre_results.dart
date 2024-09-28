import 'dart:convert';

/// adult : false
/// backdrop_path : "/x2thJwMJ6oGlhn7UC4vSwHltEw0.jpg"
/// genre_ids : [28,53,10770]
/// id : 1115396
/// original_language : "en"
/// original_title : "Hunting Games"
/// overview : "When a group of ex-military members is hired to retrieve a lost bag of stolen money, their mission becomes more difficult after a lone hunter finds the bag first."
/// popularity : 337.472
/// poster_path : "/xVbEJzdMxIQqpuLgla0hU8qr9mt.jpg"
/// release_date : "2023-05-12"
/// title : "Hunting Games"
/// video : false
/// vote_average : 4.65
/// vote_count : 10

Genre resultsFromJson(String str) => Genre.fromJson(json.decode(str));

String resultsToJson(Genre data) => json.encode(data.toJson());

class Genre {
  Genre({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  Genre.fromJson(dynamic json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    genreIds = json['genre_ids'] != null ? json['genre_ids'].cast<num>() : [];
    id = json['id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    title = json['title'];
    video = json['video'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }

  bool? adult;
  String? backdropPath;
  List<num>? genreIds;
  num? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  num? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  num? voteAverage;
  num? voteCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['adult'] = adult;
    map['backdrop_path'] = backdropPath;
    map['genre_ids'] = genreIds;
    map['id'] = id;
    map['original_language'] = originalLanguage;
    map['original_title'] = originalTitle;
    map['overview'] = overview;
    map['popularity'] = popularity;
    map['poster_path'] = posterPath;
    map['release_date'] = releaseDate;
    map['title'] = title;
    map['video'] = video;
    map['vote_average'] = voteAverage;
    map['vote_count'] = voteCount;
    return map;
  }
}
