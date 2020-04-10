import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:map_controller/map_controller.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../country/detail.dart';
import '../country/country_detail.dart';
import 'place.dart';

class MapData extends StatefulWidget {
  @override
  _MapDataState createState() => _MapDataState();
}

class _MapDataState extends State<MapData> {
  MapController mapController;
  StatefulMapController statefulMapController;
  StreamSubscription<StatefulMapControllerStateChange> sub;

  bool ready = false;

  List names = new List();
  List filteredNames = new List();
  List<User> listModel = [];
  var loading = false;

  final List<Place> places = <Place>[];

  final _markersOnMap = <Place>[];

  void addMarker() async {
    setState(() {
      loading = true;
    });
    final responseData = await http.get("https://corona.lmao.ninja/countries");
    if (responseData.statusCode == 200) {
      final data = jsonDecode(responseData.body);
      setState(() {
        for (Map i in data) {
          listModel.add(User.fromJson(i));
        }
      });
    }
    for (int i = 0; i < listModel.length; i++) {
      places.add(Place(
          listModel[i].countryInfo.flag,
          listModel[i].country,
          listModel[i].cases,
          listModel[i].todayCases,
          listModel[i].deaths,
          listModel[i].todayDeaths,
          listModel[i].recovered,
          listModel[i].active,
          listModel[i].critical,
          listModel[i].casesPerOneMillion,
          listModel[i].deathsPerOneMillion,
          listModel[i].tests,
          listModel[i].testsPerOneMillion,
          LatLng(
              (listModel[i].countryInfo.lat), listModel[i].countryInfo.long)));
    }
    for (final place in places) {
      var color;
      if (!_markersOnMap.contains(place)) {
        print("Adding marker ${place.country}");
        if(place.cases < 100){
        color = Colors.blue;
      }else if(place.cases < 1000){color = Colors.amber;}
      else if(place.cases < 10000){color = Colors.orange;}
      else {color = Colors.red;}
        statefulMapController.addMarker(
          name: place.country,
          marker: Marker(
            point: place.point,
            builder: (ctx) => new Container(
              child: new IconButton(
                icon: Icon(
                  Icons.account_circle,
                  color: color,
                  size: 30.0,
                ),
                tooltip: place.country,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CountaryDetail(
                                dCountry: place.country,
                                dUrl: place.url,
                                dCases: place.cases,
                                dTodayCases: place.todayCases,
                                dDeaths: place.deaths,
                                dTodayDeaths: place.todayDeaths,
                                dRecovered: place.recovered,
                                dActive: place.active,
                                dCritical: place.critical,
                                dCasesPerOneMillion: place.casesPerOneMillion,
                                dDeathsPerOneMillion: place.deathsPerOneMillion,
                                dTests: place.tests,
                                dTestsPerOneMillion: place.testsPerOneMillion,
                              )));
                },
              ),
            ),
          ),
        );
      }
        _markersOnMap.add(place);
    }
            loading = false;
  }


  @override
  void initState() {
    // getData();
    mapController = MapController();
    statefulMapController = StatefulMapController(mapController: mapController);
    statefulMapController.onReady.then((_) { addMarker();setState(() => ready = true);});
    sub = statefulMapController.changeFeed.listen((change) => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: loading ? <Widget>[
         Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
      ]:<Widget>[
        new FlutterMap(
          mapController: mapController,
          options: new MapOptions(
            center: LatLng(2.3949, 84.1240),
            zoom: 3.0,
          ),
          layers: [
            statefulMapController.tileLayer,
            // statefulMapController.switchTileLayer(TileLayerType.monochrome),
            MarkerLayerOptions(markers: statefulMapController.markers),
          ],
        ),
        Positioned(
            top: 20.0,
            right: 8.0,
            child: TileLayersBar(controller: statefulMapController),
            ),
        // Positioned(
        //     bottom: 20.0,
        //     right: 15.0,
        //     child: new IconButton(
        //       icon: Icon(Icons.layers,size: 40.0,),
        //       onPressed: (){
        //          Navigator.push(
        //               context,
        //               MaterialPageRoute(
        //                   builder: (context) => null));
        //       }
        //        ),
        //     ),
      ],
    );
  }

  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }
}
