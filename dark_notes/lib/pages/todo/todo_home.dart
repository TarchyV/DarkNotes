import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class ToDo extends StatefulWidget{

  final String userId;
  ToDo(this.userId);
  @override
  State<StatefulWidget> createState() => _ToDo();
  }


class _ToDo extends State<ToDo>{
   final databaseReference = Firestore.instance;
   String toDo = ' ';
  @override
  void initState() {

    super.initState();
        _getToDo();
  }



  void createToDoBox(){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          backgroundColor: Colors.white24,
          title: Text('What Do You Need To Do?', style: TextStyle(color: Colors.white60),),
          content: Container(
            height: 125,
            child: Column(
              children: <Widget>[
                Container(
                  decoration: new BoxDecoration(
                    border: Border.all(color: Colors.white54)
                  ),
                  child: TextField(
              decoration: InputDecoration(border: InputBorder.none),     
              style: TextStyle(color: Colors.white, fontSize: 24),     
              onChanged: (text){
                setState(() {
                  toDo = text;
                });
              },        
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                    FlatButton(
                    color: Colors.white54,
                    onPressed: (){
                      //ADD TO DATABASE
                     Navigator.of(context).pop();
                      _saveToDo();
                    },
                    child: Text('Confirm', style: TextStyle(fontSize: 16, fontFamily: 'Roboto'),),
                  ),
                    FlatButton(
                    color: Colors.white54,
                    onPressed: (){
                    Navigator.of(context).pop();

                    },
                    child: Text('Cancel', style: TextStyle(fontSize: 16, fontFamily: 'Roboto'),),
                  )
                  ],),
                )
               
              ],
            ),
          ),
        );
      }
    );
    
  }
  int todoCount = 0;
  List<String> toDoString = new List();
  List<String> documents = new List();
Future<String> _getToDo() async {
databaseReference.collection('Users').document(widget.userId).collection('ToDos').getDocuments().then((QuerySnapshot snapshot){
print(snapshot.documents);
snapshot.documents.forEach((f){
print(f.data);
setState(() {
  toDoString.add(f.data.toString().substring(f.data.toString().indexOf(':') + 1, f.data.toString().indexOf('}')));
});
});
});
}

Future<String> dbCheck() async{
return databaseReference.collection('Users').document(widget.userId).collection('ToDos').getDocuments().toString();
}
void _saveToDo() async {
await databaseReference.collection('Users')
.document(widget.userId)
.collection('ToDos')
.document((toDo).toString())
.setData({
 toDo: ''
});
  }
  
  
  @override
  Widget build(BuildContext context) {
    List<StatefulWidget> toDoCard = new List.generate(toDoString.length, (int i) => ToDoCard(toDoString[i]) );
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: FutureBuilder(
         future: dbCheck(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
          
          Widget child;
          if(snapshot.hasData){
            child = 
              ListView(children: toDoCard);
            
          }else{
              child = 
                Padding(
                  padding: const EdgeInsets.all(84.0),
                  child: SizedBox(child: CircularProgressIndicator(backgroundColor: Colors.white38,),
                  height: 30,
                  width: 30,
                  ),
                );
              
            }
            return Center(
        child: child,
        
            );
        },


        )//,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(side: BorderSide(color: Colors.white38, width: 2.0), borderRadius: BorderRadius.circular(36)),
        onPressed: (){
          createToDoBox();
        },
        child: Icon(
          Icons.add
        ),
      ),
    );
  }
  
}

class ToDoCard extends StatefulWidget{
  final String toDoString;
  ToDoCard(this.toDoString);
  @override
  State<StatefulWidget> createState() => _ToDoCard();

}

class _ToDoCard extends State<ToDoCard>{





  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width - 50,
      decoration: new BoxDecoration(

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(widget.toDoString, style: TextStyle(fontSize: 28),),
        ),
        Container(
          height: 40,
          width: 40,
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white38)
          ),
          child: IconButton(
            icon: Icon(Icons.check, color: Colors.white38,),
             onPressed: () {

             },
          ),
        )
      ],),
    );
  }


}