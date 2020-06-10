import 'package:charts_flutter/flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterdatabasesample/main_drawer.dart';
import 'package:pie_chart/pie_chart.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:charts_flutter/flutter.dart' as charts;

class Chart_Database extends StatefulWidget {
  @override
  _Chart_DatabaseState createState() => _Chart_DatabaseState();
}

class _Chart_DatabaseState extends State<Chart_Database> {

  List<charts.Series<Sales,String>> _seriesBarData;
  List<Sales> myData;
  _generateData(myData){
    _seriesBarData.add(
        charts.Series(
          domainFn: (Sales sales,_) => sales.saleYear.toString(),
          measureFn: (Sales sales,_) => sales.saleVal,
          id: 'Sales',
          data:myData,
          labelAccessorFn: (Sales row,_)=>"${row.saleYear}"

        )

    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sales'),
      ),
      drawer: MainDrawer(),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(context){
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('sales').snapshots(),
      builder: (context,snapshot){
        if(!snapshot.hasData){
          return LinearProgressIndicator();
        }
        else{
          List<Sales> sales = snapshot.data.documents.map((documentSnapshot) => Sales.fromMap(documentSnapshot.data)).toList();
          return _buildChart(context,sales);
        }
      },
    );
  }
  Widget _buildChart(BuildContext context,List<Sales> sales){
    myData=sales;
    _generateData(myData);
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        child: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Text(
                  "Sales by Year",
                ),
                SizedBox(height: 10,),
                Expanded(
                  child: charts.BarChart(_seriesBarData,
                  animate: true,
                    animationDuration: Duration(seconds: 5),
                    behaviors: [
                      new charts.DatumLegend(
                        entryTextStyle: charts.TextStyleSpec(
                          color: charts.MaterialPalette.purple.shadeDefault,
                          fontFamily: 'Georgia',
                          fontSize: 18
                        )
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Sales{
  final int saleVal;
  final String saleYear;
  final String colorVal;

  Sales(this.saleVal,this.saleYear,this.colorVal);

  Sales.fromMap(Map<String, dynamic> map)
  :assert(map['saleVal']!=null),
  assert(map['saleYear']!=null),
  assert(map['colorVal']!=null),
    saleVal=map['saleVal'],
    saleYear=map['saleYear'],
    colorVal=map['colorVal'];

  @override
    String toString() => "Record<$saleVal:$saleYear:$colorVal>";


}
