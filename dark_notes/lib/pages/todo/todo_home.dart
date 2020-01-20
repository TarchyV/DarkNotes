import 'package:flutter/material.dart';


class ToDo extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _ToDo();
  }


class _ToDo extends State<ToDo>{
  void createToDoBox(){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          backgroundColor: Colors.white24,
          title: Text('What Do You Need To Do?', style: TextStyle(color: Colors.white60),),
          content: Container(
            height: 100,
            child: Column(
              children: <Widget>[
                TextField(
                  
                )
              ],
            ),
          ),
        );
      }
    );
    
  }
  
  
  
  @override
  Widget build(BuildContext context) {
    List<StatefulWidget> toDoCard = new List.generate(3, (int i) => ToDoCard() );
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: ListView(children: toDoCard,),
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
          child: Text('Feed The Dogs', style: TextStyle(fontSize: 28),),
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