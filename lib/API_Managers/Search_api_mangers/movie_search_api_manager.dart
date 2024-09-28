import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:movies/Models/Search_modules/movies_from_search_response.dart';

class EndPoints {
  static const String movies = "3/search/movie";
  static const String authKey =
      "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlNGM3YzZjNjYwZjIzZGE3YTlhY2IyZmIzYjk0NGQyZiIsIm5iZiI6MTcyNzA4MTE0OC41MzQ4NjgsInN1YiI6IjY2ZjEyM2YxNTgzYzU2Y2RiMTI1ZTVkMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.EFpzq4GvrwSsrwDPPD9QvhSySkNjxtjqQEZTLR7_h6Q";
}

class MovieSearchApiManager {
  static const String baseUrl = "api.themoviedb.org";

  static Future<MoviesFromSearchResponse?> getMovieFromSearch(
      String query) async {
    var params = {"query": query};
    var url = Uri.https(baseUrl, EndPoints.movies, params);
    var response = await http.get(url, headers: {
      "Accept": "application/json",
      "Authorization": EndPoints.authKey,
    });
    print("${response.statusCode} id: search api manager");
    try {
      var jsonResponse = jsonDecode(response.body);
      var searchedMovies = MoviesFromSearchResponse.fromJson(jsonResponse);

      // Log the response

      return searchedMovies;
    } on SocketException {
      print("No Internet");
    } on HttpException {
      print("Not found");
    } on FormatException {
      print("Bad response format");
    } catch (e) {
      print(e);
    }

    return null;
  }
}
