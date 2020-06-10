import 'package:flutter/material.dart';
import 'package:flutterdatabasesample/charts_database.dart';
import 'package:flutterdatabasesample/charts_screen.dart';
import 'package:flutterdatabasesample/line_chart.dart';
import 'package:flutterdatabasesample/sign_in.dart';
import 'package:flutterdatabasesample/profileScreen.dart';
import 'package:flutterdatabasesample/login_page.dart';
import 'package:flutterdatabasesample/covid19_read.dart';

class MainDrawer extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Theme.of(context).primaryColor,
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(
                      top: 30,
                      bottom: 30,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(image: NetworkImage('https://images.unsplash.com/photo-1538162169107-a5368c525637?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
                      ),
                          fit: BoxFit.fill
                      ),

                    ),

                  ),
                  Text(
                    'Ashley',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'ashley@gmail.com',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),

                ],
              ),

            ) ,
          ),

          ListTile(
            leading: Icon(Icons.home),
            title: Text(
              'Home',
              style: TextStyle(
                  fontSize: 17
              ),
            ),
            onTap: (){
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {return ProfileScreen();}), ModalRoute.withName('/'));
            },

          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text(
              'Profile',
              style: TextStyle(
                  fontSize: 17
              ),
            ),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(
              'Settings',
              style: TextStyle(
                  fontSize: 17
              ),
            ),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.apps),
            title: Text(
              'Covid-19 Stats',
              style: TextStyle(
                  fontSize: 17
              ),
            ),
            onTap: (){
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {return CovidPage();}), ModalRoute.withName('/'));

            },
          ),
          ListTile(
            leading: Icon(Icons.apps),
            title: Text(
              'Covid-19 Pie Chart',
              style: TextStyle(
                  fontSize: 17
              ),
            ),
            onTap: (){
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {return Chart_Screen();}), ModalRoute.withName('/'));

            },
          ),
          ListTile(
            leading: Icon(Icons.apps),
            title: Text(
              'Covid-19 Live Pie Chart',
              style: TextStyle(
                  fontSize: 17
              ),
            ),
            onTap: (){
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {return VisualizationChart();}), ModalRoute.withName('/'));

            },
          ),
          ListTile(
            leading: Icon(Icons.arrow_back),
            title: Text(
              'Logout',
              style: TextStyle(
                  fontSize: 17
              ),
            ),
            onTap: () {
              signOutGoogle();
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {return LoginPage();}), ModalRoute.withName('/'));
            },
          ),

        ],

      ),
    );
  }
}
