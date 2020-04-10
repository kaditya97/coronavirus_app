import 'package:latlong/latlong.dart';

class Place {
  Place(
      this.url,
      this.country,
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
      this.point);

  final String url,
      country,
      casesPerOneMillion,
      deathsPerOneMillion,
      testsPerOneMillion;
  final int cases,
      deaths,
      recovered,
      active,
      critical,
      tests,
      todayCases,
      todayDeaths;
  final LatLng point;
}
