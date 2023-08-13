import 'package:flutter/material.dart';

class WeatherModel {
  // final DateTime date;
  final String date;
  final double temp;
  final double maxTemp;
  final double minTemp;
  final String weatherStateName;
  final String weatherStateIcon;

  WeatherModel({
    required this.date,
    required this.maxTemp,
    required this.minTemp,
    required this.temp,
    required this.weatherStateName,
    required this.weatherStateIcon,
  });
  // named Constructor make object in different shapes

  factory WeatherModel.fromJson(dynamic data) {
    var jsonData = data['forecast']['forecastday'][0]['day'];
    return WeatherModel(
        temp: data['current']['temp_c'],
        date: data['location']['localtime'],
        // date: DateTime.parse(
        //     data['location']['localtime'].replaceAll(' 0', ' 00')),
        weatherStateName: data['current']['condition']['text'],
        weatherStateIcon: data['current']['condition']['icon'],
        maxTemp: jsonData['maxtemp_c'],
        minTemp: jsonData['mintemp_c']);
  }

  MaterialColor getThemeColor() {
    if (weatherStateName == 'Sunny') {
      return Colors.yellow;
    } else if (weatherStateName == 'Cloudy' ||
        weatherStateName == 'Partly cloudy' ||
        weatherStateName == 'Overcast' ||
        weatherStateName == 'Patchy snow possible' ||
        weatherStateName == 'Light snow' ||
        weatherStateName == 'Patchy light snow') {
      return Colors.grey;
    } else if (weatherStateName == 'Mist' ||
        weatherStateName == 'Fog' ||
        weatherStateName == 'Freezing fog') {
      return Colors.blueGrey;
    } else if (weatherStateName == 'Patchy rain possible' ||
        weatherStateName == 'Patchy light drizzle' ||
        weatherStateName == 'Patchy light rain') {
      return Colors.lightBlue;
    } else if (weatherStateName == 'Light rain' ||
        weatherStateName == 'Clear' ||
        weatherStateName == 'Moderate rain at times' ||
        weatherStateName == 'Moderate rain') {
      return Colors.blue;
    } else if (weatherStateName == 'Heavy rain at times' ||
        weatherStateName == 'Heavy rain') {
      return Colors.indigo;
    } else if (weatherStateName == 'Moderate snow' ||
        weatherStateName == 'Patchy moderate snow' ||
        weatherStateName == 'Patchy heavy snow' ||
        weatherStateName == 'Heavy snow') {
      return Colors.cyan;
    } else {
      return Colors.grey;
    }
  }
  // this is draft I use it to make sure data received from API
  // @override
  // String toString() {
  //   // TODO: implement toString
  //   return "temp : $temp  mintemp : $minTemp maxTemp : $maxTemp";
  // }

// if I use Assets Images
  // String getImage() {
  //   if (weatherStateName == 'clear') {
  //     return 'assets/images/clear.png';
  //   } else if (weatherStateName == 'cloudy') {
  //     return 'assets/images/cloudy.png';
  //   } else if (weatherStateName == 'rainy') {
  //     return 'assets/images/rainy.png';
  //   } else if (weatherStateName == 'snow') {
  //     return 'assets/images/snow.png';
  //   } else if (weatherStateName == 'thunderstorm'||weatherStateName == 'thunder') {
  //     return 'assets/images/thunderstorm.png';
  //   } else {
  //     return 'assets/images/clear.png';
  //   }
  // }
}
