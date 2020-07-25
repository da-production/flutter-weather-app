import 'dart:convert';

import 'package:http/http.dart' as http;

class WeatherService{
  final url;
  WeatherService(this.url);

  getWeatherData() async{
    http.Response response = await http.get(url);
    return jsonDecode(response.body);
  }

  getCurrentWeatherData() async{
    http.Response response = await http.get(url);
    return jsonDecode(response.body);
  }

}