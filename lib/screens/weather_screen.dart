import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../screens/loading.dart';

class WeatherScreen extends StatefulWidget {
  WeatherScreen({this.parseWeatherData, this.parseAirData});
  final parseWeatherData;
  final parseAirData;
  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late String cityName;
  late String nowWeather;
  late String img_name;
  late int temp_now;
  late int temp_min;
  late int temp_max;
  late int temp_feel;
  late int wind;
  late int humid;
  late int pm2;
  late int pm10;
  @override
  void initState() {
    super.initState();
    updateData(widget.parseWeatherData, widget.parseAirData);
  }

  void updateData(dynamic weatherData, dynamic airData){
    print(weatherData);
    double temp_now_tmp =weatherData['main']['temp'];
    double temp_min_tmp = weatherData['main']['temp_min'];
    double temp_max_tmp = weatherData['main']['temp_max'];
    double temp_feel_tmp = weatherData['main']['feels_like'];
    double wind_tmp = weatherData['wind']['speed'];
    double pm2_tmp = airData['list'][0]['components']['pm2_5'];
    double pm10_tmp = airData['list'][0]['components']['pm10'];
    humid = weatherData['main']['humidity'];
    cityName = weatherData['name'];
    nowWeather = weatherData['weather'][0]['main'];
    temp_now = temp_now_tmp.round();
    temp_min = temp_min_tmp.toInt();
    temp_max = temp_max_tmp.round();
    temp_feel = temp_feel_tmp.round();
    wind = wind_tmp.round();
    pm2 = pm2_tmp.round();
    pm10 = pm10_tmp.round();

    if (nowWeather == "Clear") {
      img_name = "clear_day";
    }
    else if (nowWeather == "Rain" || nowWeather == "Drizzle") {
      img_name = "rain";
    }
    else if (nowWeather == "Snow") {
      img_name = "snow";
    }
    else if (nowWeather == "Tornado" || nowWeather == "Thunderstorm") {
      img_name = "lightning";
    }
    else {
      img_name = "cloudy";
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.near_me),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => Loading()));
            },
          iconSize: 30.0,
        )
      ),
      body: Container(
        child: Stack(
          children: [
            Image.asset('image/background.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,),
            Container(
              padding: EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 120.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$temp_now˚',
                                style: GoogleFonts.lato(
                                    fontSize: 65.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                ),
                              ),
                              Row(
                                children: [
                                  Text('$nowWeather  ',
                                      style: GoogleFonts.lato(
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white
                                    )
                                  ),
                                ],
                              ),
                          ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Image.asset('image/$img_name.png', width: 120, height: 120),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 70.0,
                          ),
                          Text(
                            '$cityName',
                            style: GoogleFonts.lato(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            ),
                          ),
                          Text(
                            '$temp_max˚ / $temp_min˚  체감온도 $temp_feel˚',
                            style: GoogleFonts.lato(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Divider(
                        height: 15.0,
                        thickness: 2.0,
                        color: Colors.white30,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                '미세먼지',
                                style: GoogleFonts.getFont('Nanum Gothic',
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: 3.0,
                              ),
                              Text(
                                '$pm2''ug/m³',
                                style: GoogleFonts.lato(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              LinearPercentIndicator(
                                width: 100,
                                animation: true,
                                lineHeight: 20.0,
                                animationDuration: 1000,
                                percent: pm2/150,
                                linearStrokeCap: LinearStrokeCap.roundAll,
                                progressColor: Colors.green,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                '초미세먼지',
                                style: GoogleFonts.getFont('Nanum Gothic',
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: 3.0,
                              ),
                              Text(
                                '$pm10''ug/m³',
                                style: GoogleFonts.lato(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              LinearPercentIndicator(
                                width: 100,
                                animation: true,
                                lineHeight: 20.0,
                                animationDuration: 1000,
                                percent: pm10/50,
                                linearStrokeCap: LinearStrokeCap.roundAll,
                                progressColor: Colors.green,
                              ),
                            ],
                          )
                        ]
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Image.asset('image/wind.png', width: 44, height: 44),
                                SizedBox(
                                  height: 3.0,
                                ),
                                Text(
                                  '바람',
                                  style: GoogleFonts.getFont('Nanum Gothic',
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: 3.0,
                                ),
                                Text(
                                  '$wind''m/s',
                                  style: GoogleFonts.lato(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Image.asset('image/humid.png', width: 44, height: 44),
                                SizedBox(
                                  height: 3.0,
                                ),
                                Text(
                                  '습도',
                                  style: GoogleFonts.getFont('Nanum Gothic',
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: 3.0,
                                ),
                                Text(
                                  ' $humid''%',
                                  style: GoogleFonts.lato(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                ),
                              ],
                            ),
                          ]
                      )
                    ],
                  )
                ],
              )

            )
          ]
        )
      )

    );
  }
}
