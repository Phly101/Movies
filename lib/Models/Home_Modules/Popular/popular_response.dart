import 'popular.dart';
import 'dart:convert';

PopularResponse popularFromJson(String str) => PopularResponse.fromJson(json.decode(str));

String popularToJson(PopularResponse data) => json.encode(data.toJson());

class PopularResponse {
  PopularResponse({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  PopularResponse.fromJson(dynamic json) {
    page = json['page'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(Popular.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  num? page;
  List<Popular>? results;
  num? totalPages;
  num? totalResults;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['page'] = page;
    if (results != null) {
      map['results'] = results?.map((v) => v.toJson()).toList();
    }
    map['total_pages'] = totalPages;
    map['total_results'] = totalResults;
    return map;
  }
}
