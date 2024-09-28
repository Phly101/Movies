import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../Models/Home_Modules/Popular/popular_response.dart';

class Endpoints {
  static const String popularMovies = "/3/movie/popular";
}

class PopularApiManager {
  static const String baseUrl = "api.themoviedb.org";

  static Future<PopularResponse?> getPopularMovies() async {
    var url = Uri.https(baseUrl, Endpoints.popularMovies);

    var response = await http.get(url, headers: {
      "Accept": "application/json",
      "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlNGM3YzZjNjYwZjIzZGE3YTlhY2IyZmIzYjk0NGQyZiIsIm5iZiI6MTcyNzA4MTE0OC41MzQ4NjgsInN1YiI6IjY2ZjEyM2YxNTgzYzU2Y2RiMTI1ZTVkMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.EFpzq4GvrwSsrwDPPD9QvhSySkNjxtjqQEZTLR7_h6Q",
    });
    print("${response.statusCode} id:popular api manager");
    try {
      var jsonResponse = jsonDecode(response.body);
      var popularResponse = PopularResponse.fromJson(jsonResponse);

      // Log the response

      return popularResponse;
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
