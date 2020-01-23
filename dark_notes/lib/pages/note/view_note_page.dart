import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dark_notes/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:dark_notes/modules/list_note.dart';
import 'package:zefyr/zefyr.dart';
import 'package:quill_delta/quill_delta.dart';
import 'dart:async';
import 'dart:convert';
import 'package:dark_notes/main.dart';
import 'edit_note_page.dart';


class ViewNotePage extends StatefulWidget
{
final String userId;
final String thisTitle;
ViewNotePage(this.userId, this.thisTitle);


  @override
  State<StatefulWidget> createState() => _ViewNotePage();

}

class _ViewNotePage extends State<ViewNotePage>{
  String document = ' ';
   NotusDocument doc = new NotusDocument();
 ZefyrController _controller;
 FocusNode _focusNode = new FocusNode();
 final databaseReference = Firestore.instance;
  String title = ' ';
 @override
  void initState() {
    _controller = ZefyrController(doc);
    _getNote();
    _getTitles();
    super.initState();
  }

void _getNote(){
databaseReference.collection('Users').document(widget.userId).collection('Notes').document(widget.thisTitle).get().then((DocumentSnapshot snapshot){

document = snapshot.data.toString().substring(snapshot.data.toString().indexOf(':') + 2,);
print(document);
setState(() {
  doc = NotusDocument.fromJson(jsonDecode(document.substring(0, document.length - 1)));
  _controller = ZefyrController(doc);
});

});


}
List<String> titles = new List();

void _getTitles(){
   databaseReference.collection('Users').document(widget.userId).collection('Notes').getDocuments(

  ).then((QuerySnapshot snapshot) {
    snapshot.documents.forEach((f){
          if(!titles.contains(f.documentID.toString())){
            setState(() {
             titles.add(f.documentID.toString());
            });
          }
    });
  });




}

  @override
  Widget build(BuildContext context) {
    final theme = ZefyrThemeData(
      cursorColor: Colors.white54,
 toolbarTheme: ZefyrToolbarTheme.fallback(context).copyWith(
        color: Colors.grey.shade800,
        toggleColor: Colors.grey.shade900,
        iconColor: Colors.white,
        disabledIconColor: Colors.grey.shade500,
      ),
    );
       final editor = ZefyrField(
    height: 600.0,
     // set the editor's height
     
    controller: _controller,
    focusNode: _focusNode,
    autofocus: false,
    physics: ClampingScrollPhysics(),
    mode: ZefyrMode.view,
  );   
    final form = ListView(
    children: <Widget>[
      Text(
        '${widget.thisTitle}',
        style: TextStyle(fontSize: 28, color: Colors.white54),
        ),
      Container(decoration: new BoxDecoration(border: Border(top: BorderSide(color: Colors.white24, width: 3))),
         child: Column(
           children: <Widget>[
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: <Widget>[
              Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Notes', style: TextStyle(color: Colors.white38),),
            ),
            Container(),
            Container()
             ],),
            

             editor
           ],
         )),
    ],
  );
  
   return Scaffold(
     appBar: AppBar(
       title: Text('View Note', style: TextStyle(color: Colors.white24),),
       backgroundColor: Colors.black,
       elevation: 0.0,
       iconTheme: IconThemeData(color: Colors.white24),
       automaticallyImplyLeading: false,
       leading: IconButton(
         icon: Icon(Icons.arrow_back_ios),
         onPressed: (){
           Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => MyApp(page:1))
            );
         },
       ),
       
     ),
     floatingActionButton: FloatingActionButton(
       backgroundColor: Colors.white24,
       onPressed: (){
         Navigator.push(context,
         MaterialPageRoute(builder: (context) => EditNotePage(widget.userId, titles, false,
         title: widget.thisTitle,
         ))
         );
       },
       child: Icon(Icons.edit),
     ),
      body: ZefyrScaffold(
        child: Container(
          decoration: new BoxDecoration(
            color: Colors.black
          ),
          child:
          
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: ZefyrTheme(
              data: theme,
              child: form,
            )
            ,
          ),
        )
      )
    );
  }


}

