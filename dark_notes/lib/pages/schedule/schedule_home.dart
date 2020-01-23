import 'package:flutter/material.dart';

class Schedule extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _Schedule();


}

class _Schedule extends State<Schedule>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(children: <Widget>[
        Container(
          child: Text('IMACALENDAR', style: TextStyle(color: Colors.white),),
        ),

        ListView(children: <Widget>[

        ],)
      ],),
    );
  }


}