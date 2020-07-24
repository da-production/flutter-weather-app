import 'package:flutter/material.dart';

void main() => runApp(WeatherApp());

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            child: Text('Weather App',style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,fontStyle: FontStyle.italic, color: Colors.white),),
          )
        ],
      ),
    );
  }
}
