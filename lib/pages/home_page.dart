import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // void updateUi() {
  //   setState(() {});
  // }

  WeatherModel? weatherData;
  @override
  Widget build(BuildContext context) {
    weatherData = Provider.of<WeatherProvider>(context).weatherData;

    return WillPopScope(
      onWillPop: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SearchPage(),
            ));
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: weatherData == null ? const Text('Weather App') : null,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const SearchPage();
                    },
                  ));
                },
                icon: const Icon(Icons.search))
          ],
        ),
        body: weatherData == null
            ? const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'there is no weather 😔 start',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      'searching now 🔍',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    )
                  ],
                ),
              )
            : Container(
                decoration: BoxDecoration(
                    color: weatherData!.getThemeColor(),
                    gradient: LinearGradient(
                      colors: [
                        weatherData!.getThemeColor(),
                        weatherData!.getThemeColor()[300]!,
                        weatherData!.getThemeColor()[100]!,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 4),
                    Text(
                      Provider.of<WeatherProvider>(context)
                          .cityName!
                          .replaceRange(
                              0,
                              1,
                              Provider.of<WeatherProvider>(context)
                                  .cityName![0]
                                  .toUpperCase()),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 55,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        weatherData!.date.length == 15
                            ? weatherData!.date.toString().substring(11, 15)
                            : weatherData!.date.toString().substring(11, 16),
                        style: const TextStyle(
                          fontSize: 22,
                        ),
                      ),
                    ),
                    // Text(
                    //   "${weatherData!.date.hour}:${weatherData!.date.minute}",
                    //   style: const TextStyle(
                    //     fontSize: 22,
                    //   ),
                    // ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              "${weatherData!.temp.round()}",
                              style: const TextStyle(
                                fontSize: 55,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              "°",
                              style: TextStyle(
                                fontSize: 30,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "max: ${weatherData!.maxTemp.round()}°",
                              style: const TextStyle(fontSize: 20),
                            ),
                            Text(
                              "min:  ${weatherData!.minTemp.round()}°",
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        )
                      ],
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                    Text(
                      weatherData!.weatherStateName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Image.network(
                      "https:${weatherData!.weatherStateIcon}",
                      height: MediaQuery.of(context).size.height / 5,
                      width: MediaQuery.of(context).size.width / 3,
                      fit: BoxFit.cover,
                    ),
                    const Spacer(flex: 4),
                  ],
                )),
      ),
    );
  }
}
