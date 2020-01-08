import 'package:dark_notes/pages/note/note_home_page.dart';
import 'package:dark_notes/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:dark_notes/pages/to-do/to-do_home_page.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:zefyr/zefyr.dart';

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

@override
  void initState() {
    Future.delayed(Duration(milliseconds: 100), () =>  _p.jumpToPage(2));
    super.initState();
  }



PageController _p = new PageController();

List<double> pos1 = [50.0,330.0,30.0];
List<double> pos4 = [60.0,75.0,50.0];
List<double> pos3 = [60.0,155.0,70.0];
List<double> pos2 = [60.0,250.0,50.0];
List<double> pos5 = [50.0,20.0,30.0];

// double tlTop = 50; double tlLeft = 330; double tlSize = 30;
// double lmTop = 60; double lmLeft = 75; double lmSize = 50;
// double mTop = 60; double mLeft = 155; double mSize = 70;
// double rmTop = 60; double rmLeft = 250; double rmSize = 50;
// double trTop = 50;double trLeft = 20;double trSize = 30;


int temp = 2;

void _getSwipeDirection(int page){


if(temp > page){
  print('swipe left');
  pageTransition(0);
  setState(() {
    temp = page;
  });
}

if(temp < page){
  print('swipe right');
  pageTransition(1);
  setState(() {
    temp = page;
  });
}


}

//0 = left : 1 = right
Future<void> pageTransition(int swipe) async {
List<double> tl1 = pos1;List<double> tl2 = pos2;List<double> tl3 = pos3;
List<double> tl4 = pos4;List<double> tl5 = pos5;
//Left Swipe
if(swipe == 1){
setState(() {
pos1 = tl2;
pos2 = tl3;
pos3 = tl4;
pos4 = tl5;
pos5 = tl1;


});

}
if(swipe == 0){
setState(() {
  pos5 = tl4;
  pos4 = tl3;
  pos3 = tl2;
  pos2 = tl1;
  pos1 = tl5;

});



}


  
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
            circle(context, pos3, 3),
            //LEFT MIDDLE CIRCLE\\
            circle(context, pos2, 2),
      //RIGHT MIDDLE CIRCLE\\
            circle(context, pos4, 4),
      //TOP LEFT CIRCLE\\
            circle(context, pos1, 1),
      //TOP RIGHT CIRCLE
            circle(context, pos5, 5),
]),
            Container(
            height: 500,
            child:  PageView(
            controller: _p,
            onPageChanged: (int x){
          _getSwipeDirection(x);
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

Widget circle(BuildContext context, List<double> pos, int cv){
   return AnimatedPositioned(
          top: pos[0],
          left:  pos[1],
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            child: Image.asset(
              cv ==3 ? 'assets/MoonLogo.png': cv==4 ?'assets/NoteImg.png': cv==2? 'assets/ToDoImg.png': cv==1? 'assets/DrawImg.png': cv==5? 'assets/CalendarImg.png': 'assets/Logo.png'
            ),
      width: pos[2],
      height: pos[2],
      decoration: new BoxDecoration(
        color: Colors.black,
        border: Border.all(color: Colors.white, width: 2),
        shape: BoxShape.circle,
      ),
    ), 
    
    
    duration: Duration(milliseconds: 200),
    
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