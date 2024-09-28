import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:movies/Models/Browse_modules/GenreModule/genre_response.dart';

class Endpoints {
  static const String moviesGenre = "/3/discover/movie";
  static const String authKey =
      "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlNGM3YzZjNjYwZjIzZGE3YTlhY2IyZmIzYjk0NGQyZiIsIm5iZiI6MTcyNzA4MTE0OC41MzQ4NjgsInN1YiI6IjY2ZjEyM2YxNTgzYzU2Y2RiMTI1ZTVkMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.EFpzq4GvrwSsrwDPPD9QvhSySkNjxtjqQEZTLR7_h6Q";
}

class GenreApiManager {
  static const String baseUrl = "api.themoviedb.org";

  static Future<GenreResponse?> getMoviesGenre(String genres) async {
    var params = {"with_genres": genres};
    var url = Uri.https(baseUrl, Endpoints.moviesGenre, params);

    var response = await http.get(url, headers: {
      "Accept": "application/json",
      "Authorization": Endpoints.authKey,
    });
    print("${response.statusCode} id: genre api manager");
    try {
      var jsonResponse = jsonDecode(response.body);
      var genresResponse = GenreResponse.fromJson(jsonResponse);

      // Log the response

      return genresResponse;
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
