import 'dart:convert';

List<User> modelUserFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String modelUserToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  String country;
  CountryInfo countryInfo;
  int cases;
  int todayCases;
  int deaths;
  int todayDeaths;
  int recovered;
  int active;
  int critical;
  String casesPerOneMillion;
  String deathsPerOneMillion;
  int tests;
  String testsPerOneMillion;

  User({
    this.country,
    this.countryInfo,
    this.cases,
    this.todayCases,
    this.deaths,
    this.todayDeaths,
    this.recovered,
    this.active,
    this.critical,
    this.casesPerOneMillion,
    this.deathsPerOneMillion,
    this.tests,
    this.testsPerOneMillion,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    country: json["country"],
    countryInfo: CountryInfo.fromJson(json["countryInfo"]),
    cases: json["cases"],
    todayCases: json["todayCases"],
    deaths: json["deaths"],
    todayDeaths: json["todayDeaths"],
    recovered: json["recovered"],
    active: json["active"],
    critical: json["critical"],
    casesPerOneMillion: json["casesPerOneMillion"].toString(),
    deathsPerOneMillion: json["deathsPerOneMillion"].toString(),
    tests: json["tests"],
    testsPerOneMillion: json["testsPerOneMillion"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "country": country,
    "countryInfo": countryInfo.toJson(),
    "cases": cases,
    "todayCases": todayCases,
    "deaths": deaths,
    "todayDeaths": todayDeaths,
    "recovered": recovered,
    "active": active,
    "critical": critical,
    "casesPerOneMillion": casesPerOneMillion,
    "deathsPerOneMillion": deathsPerOneMillion,
    "tests": tests,
    "testsPerOneMillion": testsPerOneMillion,
  };
}

class CountryInfo {
  int id;
  double lat;
  double long;
  String flag;

  CountryInfo({
    this.id,
    this.lat,
    this.long,
    this.flag,
  });

  factory CountryInfo.fromJson(Map<String, dynamic> json) => CountryInfo(
    id: json["_id"],
    lat: json["lat"].toDouble(),
    long: json["long"].toDouble(),
    flag: json["flag"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "lat": lat,
    "long": long,
    "flag": flag,
  };
}


