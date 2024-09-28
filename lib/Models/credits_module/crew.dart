import 'dart:convert';

/// adult : false
/// gender : 2
/// id : 457
/// known_for_department : "Production"
/// name : "Albert S. Ruddy"
/// original_name : "Albert S. Ruddy"
/// popularity : 4.511
/// profile_path : "/jSkLkR79OmqYHg0kx4WWXI1TYPP.jpg"
/// credit_id : "52fe422bc3a36847f80093cf"
/// department : "Production"
/// job : "Producer"

Crew crewFromJson(String str) => Crew.fromJson(json.decode(str));
String crewToJson(Crew data) => json.encode(data.toJson());
class Crew {
  Crew({
      this.adult, 
      this.gender, 
      this.id, 
      this.knownForDepartment, 
      this.name, 
      this.originalName, 
      this.popularity, 
      this.profilePath, 
      this.creditId, 
      this.department, 
      this.job,});

  Crew.fromJson(dynamic json) {
    adult = json['adult'];
    gender = json['gender'];
    id = json['id'];
    knownForDepartment = json['known_for_department'];
    name = json['name'];
    originalName = json['original_name'];
    popularity = json['popularity'];
    profilePath = json['profile_path'];
    creditId = json['credit_id'];
    department = json['department'];
    job = json['job'];
  }
  bool? adult;
  num? gender;
  num? id;
  String? knownForDepartment;
  String? name;
  String? originalName;
  num? popularity;
  String? profilePath;
  String? creditId;
  String? department;
  String? job;

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
    map['credit_id'] = creditId;
    map['department'] = department;
    map['job'] = job;
    return map;
  }

}