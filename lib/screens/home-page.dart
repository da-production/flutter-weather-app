import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:weatherApp/services/location-service.dart';
import 'package:weatherApp/utilitis/constants.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var lat;
  var lon;
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

  @override
  void initState(){
    super.initState();
    _getCurrentData();
    _getData();
  }
  Future _getData() async{
    var getLocation = LocationService();
    var location = await getLocation.getLocation();
    var latitude = location.latitude;
    var longitude = location.longitude;
//    Response response = await get('https://fcc-weather-api.glitch.me/api/current?lat=${latitude}&lon=${longitude}');
    Response response = await get('https://api.openweathermap.org/data/2.5/onecall?lat=${latitude}&lon=${longitude}&appid=${apiKey}');
    var result = jsonDecode(response.body);
    return result;
  }

  Future _getCurrentData() async{
    var getLocation = LocationService();
    var location = await getLocation.getLocation();
    var latitude = location.latitude;
    var longitude = location.longitude;
//    Response response = await get('https://fcc-weather-api.glitch.me/api/current?lat=${latitude}&lon=${longitude}');
    Response response = await get('https://api.openweathermap.org/data/2.5/weather?lat=${latitude}&lon=${longitude}&appid=${apiKey}');
    var result = jsonDecode(response.body);
    return result;
  }

  _daily(){
    return FutureBuilder(
      future: _getData(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          return Container(
            height: 250,
            child: ListView.builder(
                itemCount: snapshot.data['daily'].length,
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
                                  Text('${snapshot.data['daily'][i]['weather'][0]['main']}', style: TextStyle(fontSize: 15, color: Colors.white),),
                                  Text('${(snapshot.data['daily'][i]['temp']['day'] - (273.15)).toStringAsFixed(0)}', style: TextStyle(fontSize: 75, color: Colors.white),),
                                  Text('${snapshot.data['daily'][i]['weather'][0]['description']}', style: TextStyle(fontSize: 15, color: Colors.white),),
                                  SizedBox(height: 15,),
                                  Row(
                                    children: <Widget>[
                                      Icon(Icons.arrow_drop_up, color: Colors.white,),
                                      Text('min: ${(snapshot.data['daily'][i]['temp']['min'] - (273.15)).toStringAsFixed(0)}', style: TextStyle(fontSize: 15, color: Colors.white),),
                                      Icon(Icons.arrow_drop_down, color: Colors.white,),
                                      Text('max: ${(snapshot.data['daily'][i]['temp']['max'] - (273.15)).toStringAsFixed(0)}', style: TextStyle(fontSize: 15, color: Colors.white),),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Image(image: NetworkImage('http://openweathermap.org/img/w/${snapshot.data['daily'][i]['weather'][0]['icon']}.png'),width: 150,),
                                )
                            )
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          children: <Widget>[
                            Text('Morning: ${(snapshot.data['daily'][i]['temp']['morn'] - (273.15)).toStringAsFixed(0)}', style: TextStyle(fontSize: 15, color: Colors.white),),
                            SizedBox(width: 20,),
                            Text('Night:  ${(snapshot.data['daily'][i]['temp']['night'] - (273.15)).toStringAsFixed(0)}', style: TextStyle(fontSize: 15, color: Colors.white),),
                          ],
                        )
                      ],
                    ),
                  );
                }
            ),
          );
        }else{
          return CircularProgressIndicator();
        }

      },
    );
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
            child: Padding(padding: EdgeInsets.only(right: 15), child: Icon(Icons.sync),),
            onTap: _getData,
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
                  greyPrimary,
                  whitePrimary,
                  whitePrimary,
                  whitePrimary
                ],
              ),
            ),
          ),
          SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 40,),
                    FutureBuilder(
                      future: _getCurrentData(),
                      builder: (context, snapshot){
                        if(snapshot.hasData){
                          return Text('${snapshot.data['name']}',style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,fontStyle: FontStyle.italic, color: Colors.white),);
                        }else{
                          return Text('Loading...',style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,fontStyle: FontStyle.italic, color: Colors.white),);
                        }
                      },
                    ),

                    SizedBox(height: 20,),
                    Divider(color: Colors.white,),
                    FutureBuilder(
                        future: _getCurrentData(),
                        builder: (context, snapshot){
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
                                              Text('${snapshot.data['main']['temp'] - (273.15)}', style: TextStyle(fontSize: 75, color: Colors.white),),
                                              Text('${snapshot.data['weather'][0]['description']}', style: TextStyle(fontSize: 15, color: Colors.white),),
                                              SizedBox(height: 15,),
                                              Row(
                                                children: <Widget>[
                                                  Icon(Icons.arrow_drop_up, color: Colors.white,),
                                                  Text(' Min: ${(snapshot.data['main']['temp_min'] - (273.15)).toStringAsFixed(0)}', style: TextStyle(fontSize: 15, color: Colors.white),),
                                                  Icon(Icons.arrow_drop_down, color: Colors.white,),
                                                  Text(' Max: ${(snapshot.data['main']['temp_max'] - (273.15)).toStringAsFixed(0)}', style: TextStyle(fontSize: 15, color: Colors.white),),
                                                ],
                                              )
                                            ],
                                          )
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Image(image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/0/08/Weather_icon_-_sunny.svg/600px-Weather_icon_-_sunny.svg.png'), height: 100,),
                                      )
                                    ],
                                  ),
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
                    _daily()
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
