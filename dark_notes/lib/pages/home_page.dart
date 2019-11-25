import 'package:dark_notes/pages/create_note_page.dart';
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

void _addNote(){



}


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: new BoxDecoration(color: Colors.black),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Text('DarkNotes', style: TextStyle(color: Colors.grey, fontSize: 18),),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white24,
        onPressed: (){
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => CreateNotePage(widget.userId)));
        },
        child: Icon(
          Icons.add
        ),
      ),
    );
  }


}