import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherService {
  Future<WeatherModel> getWeather({required String cityName}) async {
    try {
      String key = '525af0fb3f8a44bb913103444230907';
      String baseUrl = 'http://api.weatherapi.com/v1';

      Uri url = Uri.parse('$baseUrl/forecast.json?key=$key&q=$cityName&days=7');

      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        WeatherModel weather = WeatherModel.fromJson(data);
        return weather;
      } else {
        // Handle non-successful response status codes, e.g., 404, 500, etc.
        throw Exception(
            'Failed to get weather data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle other exceptions, e.g., network error, timeout, etc.
      throw Exception('An error occurred while fetching weather data: $e');
    }
  }
}
