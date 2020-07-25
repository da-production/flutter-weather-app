import 'package:geolocator/geolocator.dart';

class LocationService{

  double latitude;
  double longitude;
  List info = [];

//  Future getLocation() async{
//    Geolocator().getPositionStream(LocationOptions(accuracy: LocationAccuracy.high)).listen(
//      (Position  position) {
//        return position;
//    });
//  }

  Future getLocation() async{
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    return position;
  }
}