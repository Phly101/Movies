import 'dart:convert';

/// adult : false
/// backdrop_path : "/5xpO1J9nOMli128wUGtYb9eEIwC.jpg"
/// genre_ids : [80,18]
/// id : 228723
/// original_language : "fr"
/// original_title : "Le crime d'Ovide Plouffe"
/// overview : "Ovide Plouffe has married Rita. She still tries to attract other men even after their marriage. Unhappy Ovide feels for Marie - a young French woman he had met. But his catholic background and surrounding can't let him love another woman or divorce from his wife. So Ovide finishes with Marie and plans a trip with Rita hoping for reconciliation. At the last instant he announces to Rita that he can't make the trip. She goes alone. The plane explodes, and Ovide is suspected and arrested for this horrible crime."
/// popularity : 0.97
/// poster_path : "/tAcESzeU65qFttBukYIt8ldXUGO.jpg"
/// release_date : "1984-08-29"
/// title : "Le crime d'Ovide Plouffe"
/// video : false
/// vote_average : 6.3
/// vote_count : 3

SimilarMovie resultsFromJson(String str) => SimilarMovie.fromJson(json.decode(str));

String resultsToJson(SimilarMovie data) => json.encode(data.toJson());

class SimilarMovie {
  SimilarMovie({
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

  SimilarMovie.fromJson(dynamic json) {
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
