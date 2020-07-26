import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weatherApp/screens/home-page.dart';

class CustomBottomNavBar extends StatefulWidget {
  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
//        borderRadius: BorderRadius.only(
//          topLeft: Radius.circular(40),
//          topRight: Radius.circular(40)
//        ),
        color: Colors.white,

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Container(
              width: 40,
              height: 50,
              padding: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(color: Color.fromRGBO(18, 115, 235, 1),width: 2)
                ),

              ),
              child: Stack(
                overflow: Overflow.visible,
                alignment: Alignment.center,
                children: <Widget>[
                  Positioned(
                      width: 40,
                      bottom: 10,
                      child: InkWell(

                        child: SvgPicture.asset('svg/home.svg', height: 30, width: 30,),
                        onTap: (){
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                                (Route<dynamic> route) => false,
                          );
                        },
                      )
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
