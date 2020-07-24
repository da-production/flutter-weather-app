import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var latitude;
  var longitude;

  void _getLocation() async{
    var geolocator = Geolocator();
    var locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
    geolocator.getPositionStream(locationOptions).listen(
            (Position position) {
          setState(() {
            position == null ? 'Unknown' : latitude = position.latitude.toString();
            position == null ? 'Unknown' : longitude = position.longitude.toString();
          });
        });

  }

  @override
  void initState() {
    super.initState();
    _getLocation();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [0.1, 0.5, 0.7, 0.9],
                colors: [
                  Colors.blueAccent,
                  Colors.purple,
                  Colors.deepPurple,
                  Colors.deepPurple,
                ],
              ),
            ),
          ),
          Center(
              child: Container(
                height: 130,
                child: Column(
                  children: <Widget>[
                    Text('Weather App',style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,fontStyle: FontStyle.italic, color: Colors.white),),
                    SizedBox(height: 20,),
                    Text('Latitude: ${latitude} Longitude: ${longitude}',style: TextStyle(fontSize: 15,fontStyle: FontStyle.italic, color: Colors.white),),

                    FlatButton(onPressed: null, child: Text('Home', style: TextStyle(color: Colors.white),))
                  ],
                ),
              )
          ),
        ],
      ),
    );
  }
}
