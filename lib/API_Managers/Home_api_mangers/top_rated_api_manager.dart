import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:movies/Models/Home_Modules/TopRated/top_rated_response.dart';

class Endpoints {
  static const String topRatedMovies = "/3/movie/top_rated";
}

class TopRatedApiManager {
  static const String baseUrl = "api.themoviedb.org";

  static Future<TopRatedResponse?> getTopRatedMovies() async {
    var url = Uri.https(baseUrl, Endpoints.topRatedMovies);
    var response = await http.get(url, headers: {
      "Accept": "application/json",
      "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlNGM3YzZjNjYwZjIzZGE3YTlhY2IyZmIzYjk0NGQyZiIsIm5iZiI6MTcyNzA4MTE0OC41MzQ4NjgsInN1YiI6IjY2ZjEyM2YxNTgzYzU2Y2RiMTI1ZTVkMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.EFpzq4GvrwSsrwDPPD9QvhSySkNjxtjqQEZTLR7_h6Q"
    });
     print("${response.statusCode} id:top rated api manager ");
    try {
      var jsonResponse = jsonDecode(response.body);
      var topRatedResponse = TopRatedResponse.fromJson(jsonResponse);

      return topRatedResponse;
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
