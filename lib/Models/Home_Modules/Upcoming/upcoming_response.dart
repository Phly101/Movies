

import 'package:movies/Models/Home_Modules/Upcoming/upcoming.dart';

import 'dates.dart';

import 'dart:convert';

UpcomingResponse upcomingFromJson(String str) => UpcomingResponse.fromJson(json.decode(str));

String upcomingToJson(UpcomingResponse data) => json.encode(data.toJson());

class UpcomingResponse {
  UpcomingResponse({
    Dates? dates,
    num? page,
    List<UpComing>? results,
    num? totalPages,
    num? totalResults,
  }) {
    _dates = dates;
    _page = page;
    _results = results;
    _totalPages = totalPages;
    _totalResults = totalResults;
  }

  UpcomingResponse.fromJson(dynamic json) {
    _dates = json['dates'] != null ? Dates.fromJson(json['dates']) : null;
    _page = json['page'];
    if (json['results'] != null) {
      _results = [];
      json['results'].forEach((v) {
        _results?.add(UpComing.fromJson(v));
      });
    }
    _totalPages = json['total_pages'];
    _totalResults = json['total_results'];
  }

  Dates? _dates;
  num? _page;
  List<UpComing>? _results;
  num? _totalPages;
  num? _totalResults;

  Dates? get dates => _dates;

  num? get page => _page;

  List<UpComing>? get results => _results;

  num? get totalPages => _totalPages;

  num? get totalResults => _totalResults;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_dates != null) {
      map['dates'] = _dates?.toJson();
    }
    map['page'] = _page;
    if (_results != null) {
      map['results'] = _results?.map((v) => v.toJson()).toList();
    }
    map['total_pages'] = _totalPages;
    map['total_results'] = _totalResults;
    return map;
  }
}
