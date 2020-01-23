import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../../main.dart';



class Schedule extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _Schedule();


}

class _Schedule extends State<Schedule>{
    DateTime _selectedDay = DateTime.now();

CalendarController _calendarController;
  Map<DateTime, List> _events;

    @override
  void initState() {
      _calendarController = CalendarController();
    
    super.initState();
  }

@override
void dispose() {
  _calendarController.dispose();
  super.dispose();
}

  DateTime getDate(DateTime date){
    setState(() {
      _selectedDay = date;
    });
    return _selectedDay;
    
  }

  void getEvents(){

  }

  void createEvent(){

    openDialog();
  }


void openDialog(){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          backgroundColor: Colors.white24,
          
          content: Container(
            width: 400,
            height: 120,
            child: Column(
              children: <Widget>[
                Container(
                  decoration: new BoxDecoration(
                    border: Border.all(color: Colors.white54)
                  ),
                  child: TextField(
              decoration: InputDecoration(border: InputBorder.none, hintText: "Add Your Event", hintStyle: TextStyle(color: Colors.white54)),     
              style: TextStyle(color: Colors.white, fontSize: 24,),
                   
              onChanged: (text){
                setState(() {
                });
              },        
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                    FlatButton(
                    color: Colors.white54,
                    onPressed: (){
                      //ADD TO DATABASE
                      Navigator.pop(context);
             
                    },
                    child: Text('Confirm', style: TextStyle(fontSize: 16, fontFamily: 'Roboto'),),
                  ),
                    FlatButton(
                    color: Colors.white54,
                    onPressed: (){
                    Navigator.of(context).pop();
                  setState(() { });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(children: <Widget>[
                    OutlineButton(
              borderSide: BorderSide(
                color: Colors.red[300],
              ),
              color: Colors.red,
              onPressed: (){
                createEvent();
              },
              
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
              child: Text('Add Event', style: TextStyle(color: Colors.white),),
            ),
            TableCalendar(
              calendarController: _calendarController,
              events: _events,
              calendarStyle: CalendarStyle(
                todayColor: Colors.red[600],
                selectedColor: Colors.orange
                
                
                ),
                builders: CalendarBuilders(
                  selectedDayBuilder: (context, date, _) {
          return Container(
            margin: const EdgeInsets.all(4.0),
            padding: const EdgeInsets.only(top: 5.0, left: 6.0),
            color: Colors.red[300],
            width: 100,
            height: 100,
            child: Text(
              '${date.day}',
              style: TextStyle().copyWith(fontSize: 22.0, color: Colors.white, fontFamily: 'Roboto'),
            ),
          );
        },
                ),
              onDaySelected: (date, l){
                getDate(date);
              }
            ),

            Container(
              height: 110,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: ListView(
                  
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                  ],
                ),
              ),
            )
     
      ],),
    );
  }


}