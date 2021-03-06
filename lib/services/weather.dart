import 'package:clima/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';

const String apikey = '22a59a715ba68241acdd392aa6072b61';

class WeatherModel {
  // getLocation() async {
  //  return weather;

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }

  Color getColor(int condition) {
    if (condition < 300) {
      return Color(0xD0FDE827);
    } else if (condition < 400) {
      return Color(0xD1C8FCFC);
    } else if (condition < 600) {
      return Color(0xD1BDC5F1);
    } else if (condition < 700) {
      return Color(0xD1DBD6A0);
    } else if (condition < 800) {
      return Color(0xF9E3D9E5);
    } else if (condition == 800) {
      return Colors.lightBlueAccent;
    } else if (condition <= 804) {
      return Color(0xD7D7D7F5);
    } else {
      return Colors.orange;
    }
  }
}
