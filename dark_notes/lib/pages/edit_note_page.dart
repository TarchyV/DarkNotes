import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zefyr/zefyr.dart';
import 'dart:convert';

import '../main.dart';
class EditNotePage extends StatefulWidget
{
final List<String> titles;
final String userId;
final bool newNote;
String title;
EditNotePage(this.userId, this.titles, this.newNote,{this.title});


  @override
  State<StatefulWidget> createState() => _EditNotePage();

}

class _EditNotePage extends State<EditNotePage>{
   NotusDocument doc = new NotusDocument();
 ZefyrController _controller;
 FocusNode _focusNode = new FocusNode();
 final databaseReference = Firestore.instance;
  String title = ' ';
  TextEditingController titleController = new TextEditingController();
 @override
  void initState() {
    titleController.text = widget.title;
    if(widget.newNote){
    _controller = new ZefyrController(doc);
    }else{
      _getNote();
    }
    super.initState();
  }

  void _noteListener(){

    print(_controller.document);

  }
  String document = ' ';
void _getNote(){
databaseReference.collection('Users').document(widget.userId).collection('Notes').document(widget.title).get().then((DocumentSnapshot snapshot){

document = snapshot.data.toString().substring(snapshot.data.toString().indexOf(':') + 2,);
print(document);
setState(() {
  doc = NotusDocument.fromJson(jsonDecode(document.substring(0, document.length - 1)));
  _controller = ZefyrController(doc);
      _controller.addListener(_noteListener);

});

});


}




void _saveNote() async {
if(!widget.titles.contains(title)){
await databaseReference.collection('Users')
.document(widget.userId)
.collection('Notes')
.document(title)
.setData({
 title : jsonEncode(_controller.document.toJson())
});
   Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => MyApp())
            );
print('ive done it! pt 1');
}else{
  setState(() {
    title = title + '*';
  });
}

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
        controller: titleController,
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
       title: Text(widget.newNote ? 'Create Note': 'Edit Note', style: TextStyle(color: Colors.white24),),
       backgroundColor: Colors.black,
       elevation: 0.0,
       iconTheme: IconThemeData(color: Colors.white24),
       automaticallyImplyLeading: false,
       leading: IconButton(
         icon: Icon(Icons.arrow_back_ios),
         onPressed: (){
           Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => MyApp())
            );
         },
       ),
       
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

