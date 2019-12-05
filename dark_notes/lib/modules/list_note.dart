import 'package:flutter/material.dart';
import 'package:dark_notes/pages/view_note_page.dart';
class ListNote extends StatefulWidget{
  final String title;
  final String userId;
  ListNote(this.title, this.userId);
  @override
  State<StatefulWidget> createState() => _ListNote();



}

class _ListNote extends State<ListNote>{
      String t = '';

  @override
  void initState() {
       t = widget.title;

      try{

        t = t.substring(0,t.indexOf('*'));

      }catch(e){


      }


    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
            onTap: (){
              Navigator.push(context, 
              MaterialPageRoute(
                builder:(context) => ViewNotePage(widget.userId, widget.title)
              ));
            },
          child: Container(
          height: 50,
          width: 100,
          decoration: new BoxDecoration(
            border: Border.all(color: Colors.white24, width: 1),
            borderRadius: BorderRadius.circular(16)
          ),
          child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(t, style: TextStyle(color: Colors.white38, fontSize: 18),),
                    )
                  ],

          ),


        ),
      ),
    );
  }



}