import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:weatherApp/utilitis/constants.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var latitude;
  var longitude;
  var name ='';
  List weekDays = [
    'Mondays',
    'Tuesdays',
    'Wednesdays',
    'Thursdays',
    'Fridays',
    'Saturdays',
    'Sundays',
  ];

  var i = 1;

  @override
  void initState() {
    super.initState();
    _getLocation();
    _getData();
  }

  void _getLocation() async{
    var geolocator = Geolocator();
    var locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
    geolocator.getPositionStream(locationOptions).listen(
      (Position position) {
        setState(() {
          position == null ? 'Unknown' : latitude = position.latitude.toString();
          position == null ? 'Unknown' : longitude = position.longitude.toString();
        });
        print(position.accuracy);
      }
    );
  }

  Future _getData() async{
    Response response = await get('https://fcc-weather-api.glitch.me/api/current?lat=36.7323533&lon=3.04976');
    var result = jsonDecode(response.body);
    return result;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        backgroundColor: greyPrimary,
        centerTitle: true,
        elevation: 0 ,
        actions: <Widget>[
          InkWell(
            child: Padding(padding: EdgeInsets.only(right: 15), child: Icon(Icons.add),),
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                tileMode: TileMode.clamp,
                stops: [0.0, 0.3,0.5, 1],
                colors: [
//                  orangewhite,
//                  orangePrimary,
//                  orangePrimary,
//                  orangePrimary,
                  greyPrimary,
                  whitePrimary,
                  whitePrimary,
                  whitePrimary
                ],
              ),
            ),
          ),
          Center(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 40,),
                    FutureBuilder(
                      future: _getData(),
                      builder: (context, snapshot){
                        if(snapshot.hasData){
                          return Text('${snapshot.data['name']}',style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,fontStyle: FontStyle.italic, color: Colors.white),);
                        }else{
                          return Text('Loading...',style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,fontStyle: FontStyle.italic, color: Colors.white),);
                        }
                      },
                    ),

                    SizedBox(height: 20,),
                    Text('Latitude: ${latitude} Longitude: ${longitude}',style: TextStyle(fontSize: 15,fontStyle: FontStyle.italic, color: Colors.white),),
                    Divider(color: Colors.white,),
                    FutureBuilder(
                        future: _getData(),
                        builder: (context, snapshot){
                          //print(snapshot);
                          if(snapshot.hasData){

                            return Padding(
                              padding: EdgeInsets.all(15),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                          flex:2,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text('${snapshot.data['weather'][0]['main']}', style: TextStyle(fontSize: 15, color: Colors.white),),
                                              Text('${snapshot.data['main']['temp']}', style: TextStyle(fontSize: 75, color: Colors.white),),
                                              Text('${snapshot.data['weather'][0]['description']}', style: TextStyle(fontSize: 15, color: Colors.white),),
                                              SizedBox(height: 15,),
                                              Row(
                                                children: <Widget>[
                                                  Icon(Icons.arrow_drop_up, color: Colors.white,),
                                                  Text('${snapshot.data['main']['temp_min']}', style: TextStyle(fontSize: 15, color: Colors.white),),
                                                  Icon(Icons.arrow_drop_down, color: Colors.white,),
                                                  Text('${snapshot.data['main']['temp_max']}', style: TextStyle(fontSize: 15, color: Colors.white),),
                                                ],
                                              )
                                            ],
                                          )
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Image(image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/0/08/Weather_icon_-_sunny.svg/600px-Weather_icon_-_sunny.svg.png'),),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            );
                          }else{
                            return CircularProgressIndicator();
                          }

                        }),
                    Divider(color: Colors.white,height: 1,),
                    SizedBox(height: 15,),
                    Text('daily',style: TextStyle(fontSize: 15, color: Colors.white),),
                    SizedBox(height: 15,),
                    Container(
                      height: 250,
                      child: ListView.builder(
                          itemCount: 7,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, i){
                            return Container(
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.all(10),
                              width: 300,
                              height: 100,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(0, 0, 0, 0.2),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color.fromRGBO(0, 0, 0, 0.1),
                                        offset: Offset(0,10),
                                        spreadRadius: 5,
                                        blurRadius: 10
                                    )
                                  ]
                              ),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.all(5),
                                              child: Text(weekDays[i],style: TextStyle(fontSize: 20, color: Colors.white),),
                                            ),
                                            Text('clouds', style: TextStyle(fontSize: 15, color: Colors.white),),
                                            Text('30', style: TextStyle(fontSize: 75, color: Colors.white),),
                                            Text('broken clouds', style: TextStyle(fontSize: 15, color: Colors.white),),
                                            SizedBox(height: 15,),
                                            Row(
                                              children: <Widget>[
                                                Icon(Icons.arrow_drop_up, color: Colors.white,),
                                                Text('23', style: TextStyle(fontSize: 15, color: Colors.white),),
                                                Icon(Icons.arrow_drop_down, color: Colors.white,),
                                                Text('29', style: TextStyle(fontSize: 15, color: Colors.white),),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Image(image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/0/08/Weather_icon_-_sunny.svg/600px-Weather_icon_-_sunny.svg.png'),),
                                          )
                                      )
                                    ],
                                  )
                                ],
                              ),
                            );
                          }
                      ),
                    )
                  ],
                ),
              )
          ),
        ],
      ),
      drawer: Drawer(),
    );
  }
}
