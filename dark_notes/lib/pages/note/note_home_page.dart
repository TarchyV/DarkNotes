import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dark_notes/pages/note/edit_note_page.dart';
import 'package:dark_notes/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:dark_notes/modules/list_note.dart';

class NoteHomePage extends StatefulWidget
{

NoteHomePage({Key key, this.userId,this.auth, this.onSignedOut})
: super(key:key);

  final String userId;
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  @override
  State<StatefulWidget> createState() => _NoteHomePage();

}

class _NoteHomePage extends State<NoteHomePage>{
int noteCount = 0;
String title = "no title";
 final databaseReference = Firestore.instance;
@override
  void initState() {
    getNotes();
    super.initState();
  }

List<String> titles = new List();

void getNotes(){
   databaseReference.collection('Users').document(widget.userId).collection('Notes').getDocuments(

  ).then((QuerySnapshot snapshot) {
    snapshot.documents.forEach((f){
          if(!titles.contains(f.documentID.toString())){
            setState(() {
             titles.add(f.documentID.toString());
             noteCount = noteCount + 1;
            });
          }
    });
  });




}

 @override
  Widget build(BuildContext context) {
    List<StatefulWidget> noteList = List.generate(noteCount, (int i) => ListNote(titles[i], widget.userId));
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: new BoxDecoration(color: Colors.black),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Text('DarkNotes', style: TextStyle(color: Colors.grey, fontSize: 18),),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 120,
              child: ListView(
                children: noteList
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white24,
        onPressed: (){
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => EditNotePage(widget.userId, titles, true)));
        },
        child: Icon(
          Icons.add
        ),
      ),
    );
  }


}
