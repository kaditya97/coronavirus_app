import 'package:flutter/material.dart';

class CountaryDetail extends StatefulWidget {
  final String dUrl,
      dCountry,
      dCasesPerOneMillion,
      dDeathsPerOneMillion,
      dTestsPerOneMillion;
  final int dCases,
      dDeaths,
      dRecovered,
      dActive,
      dCritical,
      dTests,
      dTodayCases,
      dTodayDeaths;

  CountaryDetail(
      {this.dUrl,
      this.dCountry,
      this.dCases,
      this.dTodayCases,
      this.dDeaths,
      this.dTodayDeaths,
      this.dRecovered,
      this.dActive,
      this.dCritical,
      this.dCasesPerOneMillion,
      this.dDeathsPerOneMillion,
      this.dTestsPerOneMillion,
      this.dTests});

  @override
  _CountaryDetailState createState() => _CountaryDetailState();
}

class _CountaryDetailState extends State<CountaryDetail> {
  @override
  Widget build(BuildContext context) {
    var url = (widget.dUrl).toString();
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.dCountry}"),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5),
            child: Card(
              color: Colors.amber[100],
              child: Padding(
                padding: EdgeInsets.all(4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Image.network(url, height: 100, width: 150, scale: 1.0),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: Text(
                        '${widget.dCountry}',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            child: Column(
              children: <Widget>[
                new CountryDetail(
                  country: widget.dCountry,
                  cases: (widget.dCases).toString(),
                  todayCases: (widget.dTodayCases).toString(),
                  deaths: (widget.dDeaths).toString(),
                  todayDeaths: (widget.dTodayDeaths).toString(),
                  recovered: (widget.dRecovered).toString(),
                  active: (widget.dActive).toString(),
                  critical: (widget.dCritical).toString(),
                  casesPerOneMillion: (widget.dCasesPerOneMillion).toString(),
                  deathsPerOneMillion: (widget.dDeathsPerOneMillion).toString(),
                  testsPerOneMillion: (widget.dTestsPerOneMillion).toString(),
                  tests: (widget.dTests).toString(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CountryDetail extends StatelessWidget {
  final String country, cases, todayCases, deaths, todayDeaths, active, recovered, critical, casesPerOneMillion, deathsPerOneMillion, tests, testsPerOneMillion;
  CountryDetail({this.country, this.cases, this.todayCases, this.deaths, this.todayDeaths, this.active, this.recovered, this.critical, this.casesPerOneMillion, this.deathsPerOneMillion, this.tests, this.testsPerOneMillion,});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
                     Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Cases: ',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            'Cases Today: ',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            'Deaths: ',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            'Deaths Today: ',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            'Recovered: ',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            'Active: ',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            'Critical: ',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            'Cases Per One Million: ',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            'Deaths Per One Million: ',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            'Tests: ',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            'Tests Per One Million: ',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            cases,
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            todayCases,
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            deaths,
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            todayDeaths,
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            recovered,
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            active,
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            critical,
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            casesPerOneMillion,
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            deathsPerOneMillion,
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            tests,
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            testsPerOneMillion,
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    )
                  ],
      ),
    );
  }
}
