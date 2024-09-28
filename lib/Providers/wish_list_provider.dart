import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../DataBase/movie.dart';

class WishListProvider extends ChangeNotifier {
  late final Box<Movie> box;

  void init(Box<Movie> movieBox) {
    box = movieBox;
  }


  void toggleBookmark(num movieId, String? posterPath, String? originalTitle, String? overview,String? releaseDate) {
    if (isBookmarked(movieId)) {
      removeBookmark(movieId);
    } else {
      addBookmark(movieId, posterPath,originalTitle,overview,releaseDate);
    }
    notifyListeners();
  }

  void addBookmark(num movieId, String? posterPath, String? originalTitle, String? overview, String? releaseDate) {
    // Fetch the movie data you want to store
    final movie = Movie(
      id: movieId,
      posterPath: posterPath,
      originalTitle: originalTitle,
      overview: overview,
      releaseDate: releaseDate

    );
    box.put(movieId, movie);
  }

  void removeBookmark(num movieId) {
    box.delete(movieId);
    notifyListeners();
  }

  bool isBookmarked(num movieId) {
    return box.containsKey(movieId);
  }
  List<Movie> getBookmarks() {
    return box.values.toList();
  }

}
