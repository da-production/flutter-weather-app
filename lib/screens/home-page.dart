import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weatherApp/screens/weather-page.dart';
import 'package:weatherApp/services/location-service.dart';
import 'package:weatherApp/services/weather-service.dart';
import 'package:weatherApp/utilitis/constants.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState(){
    super.initState();
    initWeatherData();
  }

  Future<void> initWeatherData() async {
    var current = await _getCurrentData();
    var daily = await _getData();

    return Navigator.push(context, MaterialPageRoute(builder: (context){
      return WeatherPage(current: current, daily: daily );
    }));
  }

  Future _getData() async{
    var getLocation = LocationService();
    var location = await getLocation.getLocation();
    WeatherService weather = WeatherService('https://api.openweathermap.org/data/2.5/onecall?lat=${location.latitude}&lon=${location.longitude}&appid=${apiKey}');
    var result = weather.getWeatherData();
    return result;
  }

  Future _getCurrentData() async{
    var getLocation = LocationService();
    var location = await getLocation.getLocation();
    WeatherService weather = WeatherService('https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=${apiKey}');
    var result = weather.getCurrentWeatherData();
    return result;
  }



  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body:  Stack(
        children: <Widget>[
          Container(
            width: size.width,
            height: size.height ,
            //child: Image(image: AssetImage('images/bg.png'), height: size.height, width: size.width, fit: BoxFit.fill,),
            decoration: BoxDecoration(
              color: bluePrimary
            ),
          ),
          Center(
            child: Container(
              width: size.width,
              height: 200,
              child: Column(
                children: <Widget>[
                  Image(image: AssetImage('images/logo.png'), height: 150, width: 150),
                  SpinKitThreeBounce(
                    color: Colors.white,
                    size: 50.0,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
