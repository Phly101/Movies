import 'dart:convert';

/// id : 4
/// logo_path : "/gz66EfNoYPqHTYI4q9UEN4CbHRc.png"
/// name : "Paramount Pictures"
/// origin_country : "US"

ProductionCompanies productionCompaniesFromJson(String str) => ProductionCompanies.fromJson(json.decode(str));
String productionCompaniesToJson(ProductionCompanies data) => json.encode(data.toJson());
class ProductionCompanies {
  ProductionCompanies({
      this.id, 
      this.logoPath, 
      this.name, 
      this.originCountry,});

  ProductionCompanies.fromJson(dynamic json) {
    id = json['id'];
    logoPath = json['logo_path'];
    name = json['name'];
    originCountry = json['origin_country'];
  }
  num? id;
  String? logoPath;
  String? name;
  String? originCountry;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['logo_path'] = logoPath;
    map['name'] = name;
    map['origin_country'] = originCountry;
    return map;
  }

}