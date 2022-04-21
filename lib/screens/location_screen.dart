import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'loading_screen.dart';
import 'city_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class LocationScreen extends StatefulWidget {
  @override
  LocationScreen(this.weather);
  final weather;

  _LocationScreenState createState() => _LocationScreenState();
}

WeatherModel w = WeatherModel();

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  int? temp;
  String? location;
  int? id;
  String? msg;
  String? icon = "";
  var color;

  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI(widget.weather);
    // print(widget.weather);
  }

  updateUI(dynamic weather) async {
    if (weather == null) {
      temp = 0;
      location = "";
      msg = "Please write correct location";
      id = 0;
      icon = "";
      color = Colors.lightBlueAccent;
      return;
    }
    setState(() {
      double t = weather['main']['temp'];
      temp = t.toInt() - 273;
      location = weather['name'];
      id = weather['weather'][0]['id'];
      icon = w.getWeatherIcon(id!);
      msg = weather['weather'][0]['description'];
      msg = msg!.toTitleCase();
      color = w.getColor(weather['weather'][0]['id']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      body: Container(
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      setState(() {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return LoadingScreen(
                            cityname: null,
                          );
                        }));
                      });
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var cityname = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));
                      if (cityname != null) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return LoadingScreen(
                            cityname: cityname,
                          );
                        }));
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      "$temp°",
                      style: kTempTextStyle,
                    ),
                    Text(
                      icon!,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              )),
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: DefaultTextStyle(
                          style: TextStyle(
                            fontFamily: 'Spartan MB',
                            fontSize: 40.0,
                          ),
                          child: AnimatedTextKit(
                            animatedTexts: [
                              ScaleAnimatedText('$msg',
                                  duration: Duration(seconds: 6)),
                              ScaleAnimatedText('In $location',
                                  duration: Duration(seconds: 6))
                            ],
                            repeatForever: true,
                          ))) //)
                  )
            ],
          ),
        ),
      ),
    );
  }
}
