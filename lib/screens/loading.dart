import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../location.dart';
import '../network.dart';
import '../screens/weather_screen.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  final WEATHER_API_KEY = 'abfa4af0f068cc9370136ff207da94ab';
  late double latitude3;
  late double longitude3;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    Location myLocation = Location();
    await myLocation.getMyCurrentLocation();

    latitude3 = myLocation.latitude2;
    longitude3 = myLocation.longitude2;
    //latitude3 = 37.5006;
    //longitude3 = 126.7076;

    Network network = Network('https://api.openweathermap.org/data/2.5/weather?lat=$latitude3&lon=$longitude3&appid=$WEATHER_API_KEY&units=metric',
        'https://api.openweathermap.org/data/2.5/air_pollution?lat=$latitude3&lon=$longitude3&appid=$WEATHER_API_KEY');
    var weatherData = await network.getJsonData();
    var airData = await network.getAirData();
    print(airData);
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return WeatherScreen(parseWeatherData: weatherData, parseAirData: airData,);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff009fdf),
      body: Center(
        child: SpinKitRing(
          color: Colors.white,
        )
      )
    );
  }
}