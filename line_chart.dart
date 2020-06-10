
import 'package:flutter/material.dart';
import 'package:flutterdatabasesample/main_drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:syncfusion_flutter_charts/charts.dart';

//Main method for all Flutter Applications


class VisualizationChart extends StatelessWidget {

  Future<List<SalesData>> _getUsers() async {


    var data = await http.get("https://api.covid19india.org/data.json");
    var jsonData = jsonDecode(data.body);
    //    print(jsonData["statewise"][3]["state"]);
    var abcd = jsonData["statewise"] as List;
    //assumeUser(abcd.cast<String>());
    List<SalesData> users = [];
    // var state = "";

    for (var u in abcd) {
      //print(u["active"]);
//        User user = User(u["state"]);
      SalesData user = SalesData(u["state"],int.parse(u["active"]));
      users.add(user);
      //  print("Hello");
    }
    return users;

  }

  @override
  Widget build(BuildContext context) {
    {
      return Scaffold(
        appBar: AppBar(
          title: Text('Offerzen App'),
          centerTitle: true,
        ),
        drawer: MainDrawer(),
        body: Container(
          child: FutureBuilder(
            future: _getUsers(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              //debugPrint(snapshot.data);
              if(snapshot.data == null){

                return Container(
                  child: Center(
                    child: Text("Loading..."),
                  ),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index){
                  return Container(
                    child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      // Chart title
                      title: ChartTitle(text: 'States Covid Analysis'),
                      // Enable legend
                      //legend: Legend(isVisible: true),
                      // Enable tooltip
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <LineSeries<SalesData, String>>[
                        LineSeries<SalesData, String>(
                          dataSource: <SalesData>[
                            SalesData(snapshot.data[1].state, snapshot.data[1].active),
                            SalesData(snapshot.data[2].state, snapshot.data[2].active),
                            SalesData(snapshot.data[3].state, snapshot.data[3].active),
                            SalesData(snapshot.data[4].state, snapshot.data[4].active),
                            SalesData(snapshot.data[5].state, snapshot.data[5].active),

                          ],
                            xValueMapper: (SalesData sales, _) => sales.state,
                            yValueMapper: (SalesData sales, _) => sales.active

                        )
                      ],

                    ),
                  );
                },
              );
            },
          ),
        ),
      );
    }
  }

}


class SalesData{
  final String state;
  //final String district;
  final int active;
  //final String confirmed;
  //final String deaths;
  //final String recovered;

  SalesData(this.state,this.active);

}

//class SalesData {
//  SalesData(this.year, this.sales);
//  final String year;
//  final double sales;
//}
