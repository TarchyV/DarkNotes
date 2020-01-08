import 'package:dark_notes/pages/note/note_home_page.dart';
import 'package:dark_notes/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:dark_notes/pages/to-do/to-do_home_page.dart';

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

PageController _p = new PageController();



double mTop = 60; double mLeft = 155; double mSize = 70;

double lmTop = 60; double lmLeft = 75; double lmSize = 50;

double rmTop = 60; double rmLeft = 250; double rmSize = 50;

double tlTop = 50; double tlLeft = 330; double tlSize = 30;

double trTop = 50;double trLeft = 20;double trSize = 30;


int temp = 2;

Future<void> pageTransition(int page) async {
  print(page);
  setState(() {
  temp = page;
  print(_p.offset);
}); 
  //Left Swipe\\

  
}






 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Stack(
            fit: StackFit.loose,
            children: <Widget>[
          CustomPaint(
                  painter: CurvePainter(),
                  child: Container(
                    height: 200,
                    width: 800,
                ),
          ),
          //MIDDLE CIRCLE\\
          circleTransition(context, mTop, mLeft, mSize, mSize),
          //LEFT MIDDLE CIRCLE\\
          circleTransition(context, lmTop, lmLeft, lmSize, lmSize),
            //RIGHT MIDDLE CIRCLE\\
          circleTransition(context, rmTop, rmLeft, rmSize, rmSize),
            //TOP LEFT CIRCLE\\
          circleTransition(context, tlTop, tlLeft, tlSize, tlSize),
            //TOP RIGHT CIRCLE
          circleTransition(context, trTop, trLeft, trSize, trSize),
]),
          Container(
          height: 500,
          child:  PageView(
          controller: _p,
          onPageChanged: (int x){
        pageTransition(x);  
          },
          
          children: <Widget>[
            ToDoHome(),
            ToDoHome(),
            NoteHomePage(userId: widget.userId,),
            ToDoHome(),
            ToDoHome(),
        ],)
              )
          
          ],
          
          ),
      )
    );
  }


}

Widget circleTransition(BuildContext context, double top, double left, double width, double height,){
   return AnimatedPositioned(
          top: top,
          left:  left,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
      width: width,
      height: height,
      decoration: new BoxDecoration(
        color: Colors.black,
        border: Border.all(color: Colors.white, width: 2),
        shape: BoxShape.circle 
      ),
    ), duration: Duration(milliseconds: 300),
          );
}




class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.white;
    paint.style = PaintingStyle.stroke; // Change this to fill
    paint.strokeWidth = 2;

    var path = Path();

    path.moveTo(0, size.height * 0.25);
    path.quadraticBezierTo(
        size.width / 2, size.height / 1.5, size.width + 10, size.height * 0.25);
    path.lineTo(size.width, -50);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}