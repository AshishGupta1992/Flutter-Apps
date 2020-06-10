import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterdatabasesample/main_drawer.dart';
import 'package:pie_chart/pie_chart.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Chart_Screen extends StatefulWidget {
  @override
  _Chart_ScreenState createState() => _Chart_ScreenState();
}

class _Chart_ScreenState extends State<Chart_Screen> {
  Future<List<User>> _getUsers() async {

    var data = await http.get("https://api.covid19india.org/data.json");
    var jsonData = jsonDecode(data.body);
    //    print(jsonData["statewise"][3]["state"]);
    var abcd = jsonData["statewise"] as List;
    //assumeUser(abcd.cast<String>());
    List<User> users = [];
    // var state = "";

    for (var u in abcd) {
      //print(u["active"]);
//        User user = User(u["state"]);
      User user = User(u["state"],u["active"]);
      users.add(user);
      //  print("Hello");
    }
    return users;

  }

  Map<String, double> data = new Map();

  bool _loadChart = false;

  @override
  void initState() {
    Future<List<User>> ab = _getUsers();
    data.addAll({
      //ab['state'],ab['active'],
      'Maharashtra': 82968,
      'Delhi': 27654,
      'Tamil Nadu': 30172,
      'Gujarat': 19617,
      'Rajasthan': 10337,
      'Uttar Pradesh': 10103,
      'Madhya Pradesh': 9228

    });
    super.initState();
  }

  List<Color> _colors = [
    Colors.teal,
    Colors.blueAccent,
    Colors.amberAccent,
    Colors.redAccent,
    Colors.blueGrey,
    Colors.brown,
    Colors.orangeAccent
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Charts"),
      ),
      drawer: MainDrawer(),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Text(
              'Number of states with Covid-19',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            _loadChart ? PieChart(
              dataMap: data,
              colorList: _colors,
              animationDuration: Duration(milliseconds: 1500 ),
              chartLegendSpacing: 32.0,
              chartRadius: MediaQuery.of(context).size.width/2.7,
              showChartValuesInPercentage: true,
              showChartValues: true,
              showChartValuesOutside: true,
              chartValueBackgroundColor: Colors.grey[200],
              showLegends: true,
              legendPosition: LegendPosition.right,
              decimalPlaces: 1,
              showChartValueLabel: true,
              initialAngle: 0,
              chartValueStyle: defaultChartValueStyle.copyWith(
                color: Colors.blueGrey[900].withOpacity(0.9),
              ),
              chartType: ChartType.disc,
            ): SizedBox(
              height: 150,
            ),
            SizedBox(
              height: 50,
            ),
            RaisedButton(
              color: Colors.blue,
              child: Text(
                  'Click to Show Chart',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: (){
                setState(() {
                  _loadChart = true;
                });
              },
            )


          ],
        ),
      ),
    );
  }
}

class User{
  final String state;
 // final String district;
  final String active;
  //final String confirmed;
  //final String deaths;
  //final String recovered;

  User(this.state,this.active);

}
