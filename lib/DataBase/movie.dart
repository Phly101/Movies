import 'package:hive/hive.dart';

part 'movie.g.dart'; // This will be generated automatically

@HiveType(typeId: 0)
class Movie extends HiveObject {
  @HiveField(0)
  final num? id;

  @HiveField(1)
  final String? posterPath;

  @HiveField(2)
  final String? originalTitle;

  @HiveField(3)
  final String? overview;

  @HiveField(4)
  final String? releaseDate;

  Movie({
    required this.id,
    required this.posterPath,
    required this.originalTitle,
    required this.overview,
    required this.releaseDate
  });
}