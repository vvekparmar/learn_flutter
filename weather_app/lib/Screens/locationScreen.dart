import 'package:weather_app/Services/weather.dart';
import 'package:flutter/material.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  final locationWeather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  int temperature;
  String weatherIcon = "A";
  String cityName;
  String weatherMessage;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to get Weather Data';
        cityName = '';
        return;
      }
      temperature = weatherData['main']['temp'].toInt();
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weatherModel.getWeatherIcon(condition);
      weatherMessage = weatherModel.getMessage(temperature);
      cityName = weatherData['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://64.media.tumblr.com/942ff62c1c7ca718fca9195a72b38690/tumblr_pwk2jkvpWB1y6n681o1_1280.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              FlatButton(
                onPressed: () async {
                  var weatherData = await weatherModel.getLocationWeather();
                  updateUI(weatherData);
                },
                child: Text(
                  'Navigate',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(20, 150, 0, 0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature',
                      style: TextStyle(
                        fontSize: 50,
                      ),
                    ),
                    Text(
                      weatherIcon,
                      style: TextStyle(
                        fontSize: 50,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 200, 30, 10),
                child: Text(
                  '$weatherMessage in $cityName',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize:50,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}