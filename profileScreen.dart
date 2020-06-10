import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login_page.dart';
import 'package:flutterdatabasesample/main_drawer.dart';
import 'main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutterdatabasesample/sign_in.dart';
import 'package:flutterdatabasesample/login_page.dart';


class ProfileScreen extends StatelessWidget {


  @override


  Widget build(BuildContext context) {
    final GoogleSignIn _gSignIn =  GoogleSignIn();
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Current News',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.lightBlueAccent
      ),
      drawer: MainDrawer(),

      body: StreamBuilder(
        stream: Firestore.instance.collection('post').snapshots(),
        builder: (context,snapshot){
          if(!snapshot.hasData){
            const Text('Loading');
          }
          else{
            return ListView.builder(
              itemCount: snapshot.data.documents.length ,
              itemBuilder: (context,index){
                DocumentSnapshot mypost=snapshot.data.documents[index];
                return Stack(
                  children: <Widget>[
                    Column(children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 350,
                        child: Padding(
                          padding: EdgeInsets.only(top: 8,bottom: 8),
                          child: Material(
                            color: Colors.white,
                            elevation: 14,
                            shadowColor: Color(0x802196F3),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 200,
                                      child: Image.network(
                                        '${mypost['image']}',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Text('${mypost['title']}',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Text('${mypost['subtitle']}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.blueGrey,
                                      ),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
                    Container(
                      alignment: Alignment.topRight,
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height*0.47,
                        left: MediaQuery.of(context).size.height*0.52,
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: CircleAvatar(
                          backgroundColor: Color(0xff543B7A),
                          child: Icon(Icons.star,
                            color: Colors.white,
                            size: 20,),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        child: Icon(Icons.add),
        onPressed: (){},
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
