import 'dart:convert';

Dates datesFromJson(String str) => Dates.fromJson(json.decode(str));
String datesToJson(Dates data) => json.encode(data.toJson());
class Dates {
  Dates({
      String? maximum, 
      String? minimum,}){
    _maximum = maximum;
    _minimum = minimum;
}

  Dates.fromJson(dynamic json) {
    _maximum = json['maximum'];
    _minimum = json['minimum'];
  }
  String? _maximum;
  String? _minimum;

  String? get maximum => _maximum;
  String? get minimum => _minimum;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['maximum'] = _maximum;
    map['minimum'] = _minimum;
    return map;
  }

}