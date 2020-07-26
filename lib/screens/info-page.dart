import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weatherApp/utilitis/constants.dart';
import 'package:weatherApp/widgets/custom-bottom-navbar.dart';

class InfoCopyRight extends StatefulWidget {
  @override
  _InfoCopyRightState createState() => _InfoCopyRightState();
}

class _InfoCopyRightState extends State<InfoCopyRight> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        title: Text('A propos',style: TextStyle(color: greyPrimary),),
        backgroundColor: Colors.white70,
        centerTitle: true,
        iconTheme: IconThemeData(color: greyPrimary),
      ),
      //drawer: DrawerNavBar(),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(left: 20,right: 20,top: 20),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Text('A propos ',style: TextStyle(color: greyPrimary,fontWeight: FontWeight.bold,fontSize: 40),),
                  ),
                  Expanded(
                    flex: 2,
                    child: Hero(
                      tag: 'info-page',
                      child: SvgPicture.asset('svg/info.svg',height: 100,width: 100,fit: BoxFit.contain,),
                    ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(top:20),
                child: Divider(
                  color: greyPrimary,
                ),
              ),
              Row(
                children: <Widget>[
                  Text('Version: '),
                  Text('1.0.0'),
                ],
              ),
              Row(
                children: <Widget>[
                  Text('Date du lancement: '),
                  Text('01/07/2020'),
                ],
              ),
              Row(
                children: <Widget>[
                  Text('Date de mise à jour : '),
                  Text('01/07/2020'),
                ],
              ),
              Row(
                children: <Widget>[
                  Text('Développé par: '),
                  Text('Mebrouki Amine'),
                ],
              ),
              SizedBox(height: 20,),
              Center(
                child: Container(
                  height: 250,
                  child: Card(
                    elevation: 10,
                    child: Image(image: NetworkImage('https://media-exp1.licdn.com/dms/image/C5603AQFtjhtkQNDzvg/profile-displayphoto-shrink_200_200/0?e=1600905600&v=beta&t=V2qqeScqzxpkkCyD2K1m8QIG2YqAEI0BZGtWGcScjss')),
                  ),
                )
              )
            ],

          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}
