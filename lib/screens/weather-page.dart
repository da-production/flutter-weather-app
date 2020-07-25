import 'package:flutter/material.dart';
import 'package:weatherApp/screens/home-page.dart';
import 'package:weatherApp/utilitis/constants.dart';

class WeatherPage extends StatefulWidget {
  var daily;
  var current;
  WeatherPage({this.daily,this.current});
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  _daily(){
    return Container(
      height: 250,
      child: ListView.builder(
          itemCount: widget.daily['daily'].length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, i){
            return Container(
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(10),
              width: 300,
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
                            Text('${widget.daily['daily'][i]['weather'][0]['main']}', style: TextStyle(fontSize: 15, color: Colors.white),),
                            Text('${(widget.daily['daily'][i]['temp']['day'] - (273.15)).toStringAsFixed(0)}', style: TextStyle(fontSize: 75, color: Colors.white),),
                            Text('${widget.daily['daily'][i]['weather'][0]['description']}', style: TextStyle(fontSize: 15, color: Colors.white),),
                            SizedBox(height: 15,),
                            Row(
                              children: <Widget>[
                                Icon(Icons.arrow_drop_up, color: Colors.white,),
                                Text('min: ${(widget.daily['daily'][i]['temp']['min'] - (273.15)).toStringAsFixed(0)}', style: TextStyle(fontSize: 15, color: Colors.white),),
                                Icon(Icons.arrow_drop_down, color: Colors.white,),
                                Text('max: ${(widget.daily['daily'][i]['temp']['max'] - (273.15)).toStringAsFixed(0)}', style: TextStyle(fontSize: 15, color: Colors.white),),
                              ],
                            )
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Image(image: NetworkImage('http://openweathermap.org/img/w/${widget.daily['daily'][i]['weather'][0]['icon']}.png'),width: 150,),
                          )
                      )
                    ],
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: <Widget>[
                      Text('Morning: ${(widget.daily['daily'][i]['temp']['morn'] - (273.15)).toStringAsFixed(0)}', style: TextStyle(fontSize: 15, color: Colors.white),),
                      SizedBox(width: 20,),
                      Text('Night:  ${(widget.daily['daily'][i]['temp']['night'] - (273.15)).toStringAsFixed(0)}', style: TextStyle(fontSize: 15, color: Colors.white),),
                    ],
                  )
                ],
              ),
            );
          }
      ),
    );
  }

  _current(){
    return SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              SizedBox(height: 40,),
          Text('${widget.current['name']}',style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,fontStyle: FontStyle.italic, color: Colors.white),),

              SizedBox(height: 20,),
              Divider(color: Colors.white,),
              Padding(
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
                                Text('${widget.current['weather'][0]['main']}', style: TextStyle(fontSize: 15, color: Colors.white),),
                                Text('${widget.current['main']['temp'] - (273.15)}', style: TextStyle(fontSize: 75, color: Colors.white),),
                                Text('${widget.current['weather'][0]['description']}', style: TextStyle(fontSize: 15, color: Colors.white),),
                                SizedBox(height: 15,),
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.arrow_drop_up, color: Colors.white,),
                                    Text(' Min: ${(widget.current['main']['temp_min'] - (273.15)).toStringAsFixed(0)}', style: TextStyle(fontSize: 15, color: Colors.white),),
                                    Icon(Icons.arrow_drop_down, color: Colors.white,),
                                    Text(' Max: ${(widget.current['main']['temp_max'] - (273.15)).toStringAsFixed(0)}', style: TextStyle(fontSize: 15, color: Colors.white),),
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

              ),
              Divider(color: Colors.white,height: 1,),
              SizedBox(height: 15,),
              Text('daily',style: TextStyle(fontSize: 15, color: Colors.white),),
              SizedBox(height: 15,),
              _daily()
            ],
          ),
        )
    );
  }

  TextStyle _textShadow = TextStyle(shadows: [
    Shadow(
      color: Colors.black87,
      offset: Offset(1,1),
      blurRadius: 1
    )
  ]);
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
            onTap: (){
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
            },
          )
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountEmail: Text('enimablack@gmail.com', style: _textShadow,),
              accountName: Text('Mebrouki Amine - daProduction', style: _textShadow,),
              decoration: BoxDecoration(
                image:  DecorationImage(image: AssetImage('images/bg.png'), fit: BoxFit.fitHeight)
              ),
              currentAccountPicture: Image(image: NetworkImage('https://media-exp1.licdn.com/dms/image/C5603AQFtjhtkQNDzvg/profile-displayphoto-shrink_200_200/0?e=1600905600&v=beta&t=V2qqeScqzxpkkCyD2K1m8QIG2YqAEI0BZGtWGcScjss'),),
            )
          ],
        ),
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
            _current()
          ],
        ),
      );

  }
}
