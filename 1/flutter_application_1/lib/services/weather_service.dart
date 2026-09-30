import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constants/api_keys.dart';
import '../models/weather.dart';

class WeatherService {
  static const String _weatherHost = 'api.openweathermap.org';

  static const String _geoHost = 'api.openweathermap.org';

  Future<Weather> getWeatherByLocation({
    required double latitude,
    required double longitude,
  }) async {
    final uri = Uri.https(_weatherHost, '/data/2.5/weather', {
      'lat': latitude.toString(),
      'lon': longitude.toString(),
      'appid': openWeatherApiKey,
      'units': 'metric',
    });

    return _getWeather(uri);
  }

  Future<Weather> getWeatherByCity(String city) async {
    final coordinates = await _getCityCoordinates(city);

    return getWeatherByLocation(
      latitude: coordinates.$1,
      longitude: coordinates.$2,
    );
  }

  Future<(double, double)> _getCityCoordinates(String city) async {
    final uri = Uri.https(_geoHost, '/geo/1.0/direct', {
      'q': city,
      'limit': '1',
      'appid': openWeatherApiKey,
    });

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Unable to search city.');
    }

    final List<dynamic> data = jsonDecode(response.body);

    if (data.isEmpty) {
      throw Exception('City not found.');
    }

    final result = data.first;

    return (
      (result['lat'] as num).toDouble(),
      (result['lon'] as num).toDouble(),
    );
  }

  Future<Weather> _getWeather(Uri uri) async {
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Unable to load weather.');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;

    return Weather.fromJson(data);
  }
}
