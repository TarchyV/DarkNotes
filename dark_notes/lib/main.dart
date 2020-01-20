import 'package:dark_notes/pages/root_page.dart';
import 'package:flutter/material.dart';
import 'package:dark_notes/services/authentication.dart';




void main() => runApp(MyApp(
));
class MyApp extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Walkway', backgroundColor: Colors.black, textTheme: TextTheme(body1: TextStyle(color: Colors.white38))),
      home: new RootPage(auth: new Auth()),
      builder: (context, child){
        return MediaQuery(
          child: child,
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0, alwaysUse24HourFormat: false ),
        );
      },
      
    );
  }
}

