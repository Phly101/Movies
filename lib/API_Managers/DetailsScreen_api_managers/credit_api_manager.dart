import 'dart:convert';
import 'dart:io';
// https://api.themoviedb.org/3/movie/{movie_id}/credits
import 'package:http/http.dart' as http;

import 'package:movies/Models/credits_module/credit_response.dart';


class Endpoints {
  static const String authKey =
      "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlNGM3YzZjNjYwZjIzZGE3YTlhY2IyZmIzYjk0NGQyZiIsIm5iZiI6MTcyNzA4MTE0OC41MzQ4NjgsInN1YiI6IjY2ZjEyM2YxNTgzYzU2Y2RiMTI1ZTVkMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.EFpzq4GvrwSsrwDPPD9QvhSySkNjxtjqQEZTLR7_h6Q";
}

class CastCreditApiManager {
  static const String baseUrl = "api.themoviedb.org";

  static Future<CreditResponse?> getMovieCast(num? movieId) async {
    var url = Uri.https(baseUrl, "/3/movie/$movieId/credits");

    var response = await http.get(url, headers: {
      "Accept": "application/json",
      "Authorization": Endpoints.authKey,
    });
    print("${response.statusCode} id:  cast api manager");
    try {
      var jsonResponse = jsonDecode(response.body);
      var creditResponse = CreditResponse.fromJson(jsonResponse);

      // Log the response

      return creditResponse;
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
