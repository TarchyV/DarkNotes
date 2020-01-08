import 'package:flutter/material.dart';

class ToDoHome extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _ToDoHome();

}

class _ToDoHome extends State<ToDoHome>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
        child: Column(
          children: <Widget>[
            Text('I AM A TO DO LIST', style: TextStyle(color: Colors.white),)
          ],
        ),
      ),
    );
  }


}