import 'package:flutter/material.dart';

class ListNote extends StatefulWidget{
  final String title;
  ListNote(this.title);
  @override
  State<StatefulWidget> createState() => _ListNote();



}

class _ListNote extends State<ListNote>{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        width: 100,
        decoration: new BoxDecoration(
          border: Border.all(color: Colors.white24, width: 1)
        ),
        child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.title, style: TextStyle(color: Colors.white24, fontSize: 18),),
                  )
                ],

        ),


      ),
    );
  }



}