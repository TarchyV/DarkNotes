import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dark_notes/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:dark_notes/modules/list_note.dart';
import 'package:zefyr/zefyr.dart';
import 'package:quill_delta/quill_delta.dart';
import 'dart:async';
import 'dart:convert';
class CreateNotePage extends StatefulWidget
{

final String userId;
CreateNotePage(this.userId);


  @override
  State<StatefulWidget> createState() => _CreateNotePage();

}

class _CreateNotePage extends State<CreateNotePage>{
   NotusDocument doc = new NotusDocument();
 ZefyrController _controller;
 FocusNode _focusNode = new FocusNode();
 final databaseReference = Firestore.instance;
  String title = ' ';
 @override
  void initState() {

    _controller = new ZefyrController(doc);
    _controller.addListener(_noteListener);
    super.initState();
  }

  void _noteListener(){

    print(_controller.document);

  }

   void _saveNote() async {
await databaseReference.collection('Users')
.document(widget.userId)
.collection('Notes')
.document(title)
.setData({
 title : _controller.document.toString()
});
Navigator.pop(context);
print('ive done it! pt 1');
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
  );   
    final form = ListView(
    children: <Widget>[
      TextField(
        cursorColor: Colors.white54,
        style: TextStyle(fontSize: 28, color: Colors.white54),
        decoration: InputDecoration(hintText: 'Label', hintStyle: TextStyle(color: Colors.white24, fontSize: 28,),border: InputBorder.none),
        onChanged: (text){
          setState(() {
            title = text;
          });
        },
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
            FlatButton(
              color: Colors.white10,
              onPressed: (){
                _saveNote();
              },
              child: Text('Save Note', style: TextStyle(color: Colors.white38),),
            )
             ],),
            

             editor
           ],
         )),
    ],
  );
  
   return Scaffold(
     appBar: AppBar(
       title: Text('Create Note', style: TextStyle(color: Colors.white24),),
       backgroundColor: Colors.black,
       elevation: 0.0,
       iconTheme: IconThemeData(color: Colors.white24),
       
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

