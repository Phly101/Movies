import 'top_rated.dart';
import 'dart:convert';

TopRatedResponse topRatedFromJson(String str) => TopRatedResponse.fromJson(json.decode(str));
String topRatedToJson(TopRatedResponse data) => json.encode(data.toJson());
class TopRatedResponse {
  TopRatedResponse({
      num? page, 
      List<TopRated>? results,
      num? totalPages, 
      num? totalResults,}){
    _page = page;
    _results = results;
    _totalPages = totalPages;
    _totalResults = totalResults;
}

  TopRatedResponse.fromJson(dynamic json) {
    _page = json['page'];
    if (json['results'] != null) {
      _results = [];
      json['results'].forEach((v) {
        _results?.add(TopRated.fromJson(v));
      });
    }
    _totalPages = json['total_pages'];
    _totalResults = json['total_results'];
  }
  num? _page;
  List<TopRated>? _results;
  num? _totalPages;
  num? _totalResults;

  num? get page => _page;
  List<TopRated>? get results => _results;
  num? get totalPages => _totalPages;
  num? get totalResults => _totalResults;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['page'] = _page;
    if (_results != null) {
      map['results'] = _results?.map((v) => v.toJson()).toList();
    }
    map['total_pages'] = _totalPages;
    map['total_results'] = _totalResults;
    return map;
  }

}