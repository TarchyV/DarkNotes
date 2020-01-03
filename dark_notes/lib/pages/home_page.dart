import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dark_notes/pages/note/edit_note_page.dart';
import 'package:dark_notes/pages/note/note_home_page.dart';
import 'package:dark_notes/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:dark_notes/modules/list_note.dart';

class HomePage extends StatefulWidget
{

HomePage({Key key, this.userId,this.auth, this.onSignedOut})
: super(key:key);

  final String userId;
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  @override
  State<StatefulWidget> createState() => _HomePage();

}

class _HomePage extends State<HomePage>{

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.black,
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Positioned(
             //   top: 11,
            child: Container(
            height: 600,
            
            width: MediaQuery.of(context).size.width,
            decoration: new BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              shape: BoxShape.circle,
            ),
          ),
              )
            
            ],
          )
          
        ],
       
      )
      ),
    );
  }


}

class PageHolder extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _PageHolder();


}

class _PageHolder extends State<PageHolder>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: PageView(
          children: <Widget>[

        ],),
      ),
    );
  }


}