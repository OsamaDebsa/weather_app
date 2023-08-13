import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/providers/weather_provider.dart';
import '../Services/weather_service.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    String? cityName;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search a City"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: TextField(
            onChanged: (data) {
              cityName = data;
            },
            onSubmitted: (data) async {
              if (cityName != null && cityName!.isNotEmpty) {
                try {
                  cityName = cityName;
                  WeatherService service = WeatherService();
                  WeatherModel weather =
                      await service.getWeather(cityName: cityName!);

                  Provider.of<WeatherProvider>(context, listen: false)
                      .weatherData = weather;
                  Provider.of<WeatherProvider>(context, listen: false)
                      .cityName = cityName;
                  Navigator.pop(context);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(getErrorMessage(e)),
                    ),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please enter a city name.'),
                  ),
                );
              }
            },
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: "Enter City Name",
              label: const Text("search"),
              suffixIcon: IconButton(
                onPressed: () async {
                  if (cityName != null && cityName!.isNotEmpty) {
                    try {
                      WeatherService service = WeatherService();
                      WeatherModel weather =
                          await service.getWeather(cityName: cityName!);

                      Provider.of<WeatherProvider>(context, listen: false)
                          .weatherData = weather;
                      Provider.of<WeatherProvider>(context, listen: false)
                          .cityName = cityName;
                      Navigator.pop(context);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(getErrorMessage(e)),
                        ),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter a city name.'),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.search),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            ),
          ),
        ),
      ),
    );
  }

  String getErrorMessage(dynamic exception) {
    if (exception
        .toString()
        .contains('Failed to get weather data. Status code: 400')) {
      return 'City not found. Please check the spelling and try again.';
    } else if (exception.toString().contains('SocketException')) {
      return 'Network error. Please check your internet connection.';
    } else {
      return 'An error occurred. Please try again later.';
    }
  }
}
