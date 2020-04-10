import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Constants.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _loading = false;
  final String url = "https://corona.lmao.ninja/all";
  int cases;
  int deaths;
  int recovered;
  int active;

  @override
  void initState() {
    super.initState();
    _loading = true;
    this.getJsonData();
  }

  Future<String> getJsonData() async {
    var response = await http.get(
        //Encodeing url
        Uri.encodeFull(url),
        //only accept json response
        headers: {"Accept": "application/json"});
    setState(() {
      var data = json.decode(response.body);
      cases = data["cases"];
      deaths = data["deaths"];
      recovered = data["recovered"];
      active = data["active"];
      _loading = false;
    });

    return "success";
  }


  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Developer"),
          content: new Text("Aditya Kushwaha"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showSetting(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Setting"),
          content: new Text("Coming Soon...."),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void choiceAction(String choice) {
    if (choice == Constants.About) {
      _showDialog();
    } else if (choice == Constants.Settings) {
      _showSetting();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coronavirus Cases'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: (){
            Scaffold.of(context).openDrawer();
          }
          ),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return Constants.choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
      ),
      body: _loading
          ? Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : new ListView.builder(
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      new Card(
                        color: Colors.amber[100],
                        child: Column(
                          children: <Widget>[
                            new Container(
                              child: Icon(Icons.public, size: 120,color: Colors.green,),
                              padding: const EdgeInsets.all(20),
                            ),
                          ],
                        ),
                      ),
                      new Card(
                        child: Column(
                          children: <Widget>[
                            new Container(
                              child: Center(
                                  child: Text(
                                "Total Cases: " + cases.toString(),
                                style: TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                ),
                              )),
                              padding: const EdgeInsets.all(20),
                            ),
                          ],
                        ),
                      ),
                      new Card(
                        child: Column(
                          children: <Widget>[
                            new Container(
                              child: Center(
                                  child: Text(
                                "Total Deaths: " + deaths.toString(),
                                style: TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                ),
                              )),
                              padding: const EdgeInsets.all(20),
                            ),
                          ],
                        ),
                      ),
                      new Card(
                        child: Column(
                          children: <Widget>[
                            new Container(
                              child: Center(
                                  child: Text(
                                "Total Recovered: " + recovered.toString(),
                                style: TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                ),
                              )),
                              padding: const EdgeInsets.all(20),
                            ),
                          ],
                        ),
                      ),
                      new Card(
                        child: Column(
                          children: <Widget>[
                            new Container(
                              child: Center(
                                  child: Text(
                                "Active Cases: " + active.toString(),
                                style: TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                ),
                              )),
                              padding: const EdgeInsets.all(20),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
