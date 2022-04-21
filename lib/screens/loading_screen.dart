import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/services/networking.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:clima/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  LoadingScreen({this.cityname});
  final cityname;
  _LoadingScreenState createState() => _LoadingScreenState();
}

WeatherModel w = WeatherModel();
const String apikey = 'a804af7c5af042c9ae60ef3c7a565a58';

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();

    // getPermission().then((value) => getLocation());
    if (widget.cityname == null) {
      getLocation();
    } else {
      getcityLocation(widget.cityname);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SpinKitSpinningLines(
          color: Colors.lightBlueAccent,
          size: 100,
          lineWidth: 4,
        ),
      ),
    );
  }

  void getcityLocation(String cityname) async {
    networkhelper nh = networkhelper(
        'http://api.openweathermap.org/data/2.5/weather?q=${cityname}&appid=$apikey');
    var weather = await nh.getdata();
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(weather);
    }));
  }

  void getLocation() async {
    await Permission.location.request();

    Location l = Location();

    await l.getCurrentLocation();
    print(l.lat);
    print(l.lon);

    networkhelper nh = networkhelper(
        'http://api.openweathermap.org/data/2.5/weather?lat=${l.lat}&lon=${l.lon}&appid=$apikey');
    var weather = await nh.getdata();

    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        weather,
      );
    }));
  }
}
//Colors.primaries[Random().nextInt(Colors.primaries.length)]
