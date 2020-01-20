import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:flutter_weather_icons/flutter_weather_icons.dart';


class EclipseHome extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _EclipseHome();

}

class _EclipseHome extends State<EclipseHome>{
 static  WeatherStation weatherStation = new WeatherStation("10f39c6377634e48ab7599356d74204c");
  double celsius = 0;
  double fahrenheit = 0;
  String areaName = ' ';
  String icon = ' ';
  TimeOfDay night = TimeOfDay(hour: 20, minute: 0);
  TimeOfDay morning = TimeOfDay(hour: 7, minute: 0);
    @override
    void initState(){
      _getWeather();
      super.initState();
    }
    Future<double> _getWeather() async {
    Weather weather = await weatherStation.currentWeather();
     celsius = weather.temperature.celsius;
     fahrenheit = weather.temperature.fahrenheit;
           print(night.hour);
           print(TimeOfDay.now());
     areaName = weather.areaName;
     if(fahrenheit < 30){
      if(weather.snowLastHour > 2){
       setState(() {
         icon = 'snow';
       });
     }else{
     setState(() {
         icon = 'cold';
       });
     }
     }
     if(weather.cloudiness > 4){
       setState(() {
         icon = 'cloud';
       });
     }
    if(weather.rainLastHour > 2){
      setState(() {
        icon = 'rain';
      });
    }
    if(fahrenheit > 60 && weather.cloudiness < 3){
      setState(() {
        icon = 'sun';
      });
    }
     
     return fahrenheit;
    }
  Widget weatherIcon(BuildContext context, String i){

      Widget icon;
      if(TimeOfDay.now().hour >20 || TimeOfDay.now().hour < 7){
        icon = Icon(WeatherIcons.wiMoonFirstQuarter, color: Colors.white38,);
      }else{
        icon = Icon(WeatherIcons.wiDaySunny, color: Colors.white38);
      }
    switch(i){
      case 'snow':
        icon = Icon(WeatherIcons.wiSnow, color: Colors.white38,);
        break;
      case 'cold':
        icon = Icon(WeatherIcons.wiSnowflakeCold, color: Colors.white38);
        break;
      case 'cloud':
          icon = Icon(WeatherIcons.wiCloudy, color: Colors.white38);
        break;
      case 'rain':
          icon = Icon(WeatherIcons.wiRain, color: Colors.white38);
      
        break;
      case 'sun':
        icon = Icon(WeatherIcons.wiDaySunny, color: Colors.white38);
        break;
    }
    return icon;
    
      
  }
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
        child: FutureBuilder(
          future: _getWeather(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            List<Widget> children;
            if(snapshot.hasData){
              children = <Widget>[
          Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(8,0,8,8),
              child: Text(areaName, style: TextStyle(color: Colors.white38, fontSize: 32),),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 5),
              child: weatherIcon(context, icon),
            ),
            Text(fahrenheit.round().toString() + '°F' , style: TextStyle(color: Colors.white38, fontSize: 28),),
            ],),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(DateTime.now().month.toString() + '/' + DateTime.now().day.toString() + '/' + DateTime.now().year.toString(), style: TextStyle(color: Colors.white38, fontSize: 32),),
            )
          ],
        ),
              ];
            }else{
              children = <Widget>[
                SizedBox(child: CircularProgressIndicator(backgroundColor: Colors.white38,),
                height: 60,
                width: 60,
                )
              ];
            }
            return Center(
        child: Column(
          children: children,
        ),
            );
        },

        )
      );
    
  }

}