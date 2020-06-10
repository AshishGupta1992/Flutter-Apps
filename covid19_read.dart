import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

import 'main_drawer.dart';

class CovidPage extends StatefulWidget {
 // CovidPage({Key key,this.title}) : super(key:key);
  //final String title;

  @override
  _CovidPageState createState() => _CovidPageState();
}

class _CovidPageState extends State<CovidPage> {
  final databaseReference = Firestore.instance;

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
        User user = User(u["state"],u["district"],u["active"],u["confirmed"],u["deaths"],u["recovered"]);
       // await databaseReference.collection("covid19states")
       //     .document(u["state"])
       //     .updateData({

       //   'district':u["district"],
       //   'active': u["active"],
       //   'confirmed':u["confirmed"],
       //   'deaths': u["deaths"],
       //   'recovered':u["recovered"],

        //});
        users.add(user);
          //  print("Hello");
        }
      return users;

    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Covid-19 Status"),
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
                return Stack(

                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(),
                      child: ClipRRect(

                        borderRadius: BorderRadius.circular(15),
                        clipBehavior: Clip.hardEdge,
                        child: Container(
                          color: Colors.lightBlue,
                          margin: EdgeInsets.only(top: 5,bottom: 5,right: 20),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[

                              Container(
                                //width: MediaQuery.of(context).size.width,
                                height: 20,
                                child: Text(
                                  snapshot.data[index].state,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                              ),
                              SizedBox(height: 2,),
                              Center(
                                child: Container(
                                  //width: MediaQuery.of(context).size.width,
                                  height: 20,
                                  child: Text(
                                      snapshot.data[index].confirmed,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),

                                  ),

                                ),
                              ),
                              SizedBox(height: 2,),
                              Container(
                                //width: MediaQuery.of(context).size.width,
                                height: 20,
                                child: Text(
                                    snapshot.data[index].active,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                              ),
                            ],
                          ),
                        ),
                      ),
                    ),


                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class User{
  final String state;
  final String district;
  final String active;
  final String confirmed;
  final String deaths;
  final String recovered;

  User(this.state,this.district,this.active,this.confirmed,this.deaths,this.recovered);

}