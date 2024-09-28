
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:movies/Models/Browse_modules/browse_response.dart';

class Endpoints {
  static const String moviesGenreList = "/3/genre/movie/list";
  static const String authKey =
      "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlNGM3YzZjNjYwZjIzZGE3YTlhY2IyZmIzYjk0NGQyZiIsIm5iZiI6MTcyNzA4MTE0OC41MzQ4NjgsInN1YiI6IjY2ZjEyM2YxNTgzYzU2Y2RiMTI1ZTVkMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.EFpzq4GvrwSsrwDPPD9QvhSySkNjxtjqQEZTLR7_h6Q";
}

class BrowseApiManager {
  static const String baseUrl = "api.themoviedb.org";

  static Future<BrowseResponse?> getMoviesGenreIds() async {
    var url = Uri.https(baseUrl, Endpoints.moviesGenreList);

    var response = await http.get(url, headers: {
      "Accept": "application/json",
      "Authorization":
          Endpoints.authKey,
    });
    print("${response.statusCode} id: browse api manager");
    try {
      var jsonResponse = jsonDecode(response.body);
      var browseResponse = BrowseResponse.fromJson(jsonResponse);

      // Log the response

      return browseResponse;
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
