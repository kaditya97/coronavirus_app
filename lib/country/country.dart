import 'dart:convert';
import 'detail.dart';
import 'country_detail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";
  List names = new List();
  List filteredNames = new List();
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text('Affected Countries');


  // Membuat List Dari data Internet
  List<User> listModel = [];
  var loading = false;


  _HomePageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = names;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  Future<Null> getData() async {
    setState(() {
      loading = true;
    });

    // final responseData = await http.get("https://jsonplaceholder.typicode.com/users");
    final responseData = await http.get("https://corona.lmao.ninja/countries");

    if (responseData.statusCode == 200) {
      final data = jsonDecode(responseData.body);
      setState(() {
        for (Map i in data) {
          listModel.add(User.fromJson(i));
        }
        loading = false;
      });
    }
  }

  //Panggil Data / Call Data
  @override
  void initState() {
    super.initState();
    this._getNames();
    getData();
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      automaticallyImplyLeading: false,
      title: _appBarTitle,
      actions: <Widget>[
        IconButton(
          icon: _searchIcon,
          onPressed: _searchPressed,
        )
      ],
    );
  }


  Widget _buildList() {
    if ((_searchText.isNotEmpty)) {
      List tempList = new List();
      for (int i = 0; i < filteredNames.length; i++) {
        if (filteredNames[i].country
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          tempList.add(filteredNames[i]);
        }
      }
      filteredNames = tempList;
    }

    return ListView.builder(
        itemCount: filteredNames.length,
        itemBuilder: (context, i) {
          final nDataList = filteredNames[i];
          var url = (nDataList.countryInfo.flag).toString();
          return Container(
            child: InkWell(
               onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CountaryDetail(
                      dCountry: nDataList.country,
                      dUrl: nDataList.countryInfo.flag,
                      dCases: nDataList.cases,
                      dTodayCases: nDataList.todayCases,
                      dDeaths: nDataList.deaths,
                      dTodayDeaths: nDataList.todayDeaths,
                      dRecovered: nDataList.recovered,
                      dActive: nDataList.active,
                      dCritical: nDataList.critical,
                      dCasesPerOneMillion: nDataList.casesPerOneMillion,
                      dDeathsPerOneMillion: nDataList.deathsPerOneMillion,
                      dTests: nDataList.tests,
                      dTestsPerOneMillion: nDataList.testsPerOneMillion,
                    )));
                  },
              child: Card(
                color: Colors.amber[100],
                margin: EdgeInsets.all(15),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Image.network(url, height: 50, width: 50, scale: 1.0),
                      Text(
                        nDataList.country,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.green),
                      ),
                      Text("Total Cases: " + (nDataList.cases).toString(),
                          style: TextStyle(fontSize: 15)),
                      Text("Total Deaths: " + (nDataList.deaths).toString(),
                          style: TextStyle(fontSize: 15)),
                      Text(
                          "Total Recovred: " + (nDataList.recovered).toString(),
                          style: TextStyle(fontSize: 15)),
                      Text("Active Cases: " + (nDataList.active).toString(),
                          style: TextStyle(fontSize: 15)),
                      Text("Critical Cases: " + (nDataList.critical).toString(),
                          style: TextStyle(fontSize: 15)),
                      Text("Total Tests: " + (nDataList.tests).toString(),
                          style: TextStyle(fontSize: 15)),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildBar(context),
      body: Container(
        child: loading
            ? Center(child: CircularProgressIndicator())
            : Container(
                child: _buildList(),
              ),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          controller: _filter,
          autofocus: true,
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search), hintText: 'Search...'),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text('Affected Countries');
        filteredNames = names;
        _filter.clear();
      }
    });
  }

  void _getNames() async {
    List tempList = new List();
    final repoData = await http.get("https://corona.lmao.ninja/countries");
     final datas = jsonDecode(repoData.body);
        for (Map i in datas) {
          listModel.add(User.fromJson(i));
        }
    for (int i = 0; i < listModel.length; i++) {
      tempList.add(listModel[i]);
    }
    setState(() {
      names = tempList;
      filteredNames = names;
    });
  }
}

