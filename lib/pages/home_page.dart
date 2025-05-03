import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/pages/serch_weather__page.dart';
import 'package:weather_app/providers/theme_provider.dart';
import 'package:weather_app/services/weather_services.dart';
import 'package:weather_app/widgets/display_weather.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WeatherServices _weatherServices = WeatherServices(
    apikey: dotenv.env["OPEN_WEATHER_API_KEY"] ?? "",
  );

  Weather? _weather;
  // method to fetch the weather
  void fetchwWeather() async {
    try {
      final weather = await _weatherServices.getLocationFromCurentLocation();

      setState(() {
        _weather = weather;
      });
    } catch (error) {
      // ignore: avoid_print
      print("error from weather data:$error");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchwWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Easy weather",
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<ThemeProvider>(
                context,
                listen: false,
              ).toggleTheme(Theme.of(context).brightness != Brightness.dark);
            },
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
          ),
        ],
      ),
      body:
          _weather != null
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WeatherDisplay(weather: _weather!),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchWeatherPage(),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(107, 255, 208, 128),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Search Weather",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 251, 78, 162),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              )
              : const Center(child: CircularProgressIndicator()),
    );
  }
}
