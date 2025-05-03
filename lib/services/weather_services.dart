import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/get_location_service.dart';

class WeatherServices {
  // https://api.openweathermap.org/data/2.5/weather?q=London&appid=7a01cb7d86ef3d4852e5998224906cb3&units=metric

  // ignore: constant_identifier_names
  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
  final String apikey;

  WeatherServices({required this.apikey});

  // get the weather from the city name
  Future<Weather> getWeather(String cityName) async {
    try {
      final url = "$BASE_URL?q=$cityName&appid=$apikey&units=metric";
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return Weather.fromJson(json);
      } else {
        throw Exception("faild to load the weather data");
      }
    } catch (error) {
      throw Exception("faild tp load the weather data");
    }
  }

  // get the weather from the current location
  Future<Weather> getLocationFromCurentLocation() async {
    try {
      final location = GetLocationService();
      final cityName = await location.getLocationFromCurentLocation();

      final url = "$BASE_URL?q=$cityName&appid=$apikey&units=metric";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return Weather.fromJson(json);
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      throw Exception('Failed to load weather data');
    }
  }
}
