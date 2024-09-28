import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:movies/Models/Home_Modules/Upcoming/upcoming_response.dart';

class Endpoints {
  static const String upcomingMovies = "/3/movie/upcoming";
}

class UpComingApiManager {
  static const String baseUrl = "api.themoviedb.org";

  static Future<UpcomingResponse?> getUpComingMovies() async {
    var url = Uri.https(baseUrl, Endpoints.upcomingMovies);
    var response = await http.get(url, headers: {
      "Accept": "application/json",
      "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlNGM3YzZjNjYwZjIzZGE3YTlhY2IyZmIzYjk0NGQyZiIsIm5iZiI6MTcyNzA4MTE0OC41MzQ4NjgsInN1YiI6IjY2ZjEyM2YxNTgzYzU2Y2RiMTI1ZTVkMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.EFpzq4GvrwSsrwDPPD9QvhSySkNjxtjqQEZTLR7_h6Q"
    });
     print("${response.statusCode} id:upcoming api manager");
    try {
      var jsonResponse = jsonDecode(response.body);
      var upcomingResponse = UpcomingResponse.fromJson(jsonResponse);

      return upcomingResponse;
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
