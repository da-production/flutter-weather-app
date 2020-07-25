import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';

class LocationService{

  double latitude;
  double longitude;

  Future<void> getLocation() async{
    try{
      var geolocator =   Geolocator();
      var locationOptions =  LocationOptions(accuracy: LocationAccuracy.high);
      geolocator.getPositionStream(locationOptions).listen(
        (Position  position)  {
            position == null ? 'Unknown' : latitude = position.latitude;
            position == null ? 'Unknown' : longitude = position.longitude;
      });
    }catch(e){
      throw 'Location errors: ${e}';
    }

  }
}