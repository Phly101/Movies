import 'dart:convert';

/// adult : false
/// gender : 2
/// id : 3084
/// known_for_department : "Acting"
/// name : "Marlon Brando"
/// original_name : "Marlon Brando"
/// popularity : 22.393
/// profile_path : "/fuTEPMsBtV1zE98ujPONbKiYDc2.jpg"
/// cast_id : 146
/// character : "Don Vito Corleone"
/// credit_id : "6489aa85e2726001072483a9"
/// order : 0

Cast castFromJson(String str) => Cast.fromJson(json.decode(str));
String castToJson(Cast data) => json.encode(data.toJson());
class Cast {
  Cast({
      this.adult, 
      this.gender, 
      this.id, 
      this.knownForDepartment, 
      this.name, 
      this.originalName, 
      this.popularity, 
      this.profilePath, 
      this.castId, 
      this.character, 
      this.creditId, 
      this.order,});

  Cast.fromJson(dynamic json) {
    adult = json['adult'];
    gender = json['gender'];
    id = json['id'];
    knownForDepartment = json['known_for_department'];
    name = json['name'];
    originalName = json['original_name'];
    popularity = json['popularity'];
    profilePath = json['profile_path'];
    castId = json['cast_id'];
    character = json['character'];
    creditId = json['credit_id'];
    order = json['order'];
  }
  bool? adult;
  num? gender;
  num? id;
  String? knownForDepartment;
  String? name;
  String? originalName;
  num? popularity;
  String? profilePath;
  num? castId;
  String? character;
  String? creditId;
  num? order;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['adult'] = adult;
    map['gender'] = gender;
    map['id'] = id;
    map['known_for_department'] = knownForDepartment;
    map['name'] = name;
    map['original_name'] = originalName;
    map['popularity'] = popularity;
    map['profile_path'] = profilePath;
    map['cast_id'] = castId;
    map['character'] = character;
    map['credit_id'] = creditId;
    map['order'] = order;
    return map;
  }

}