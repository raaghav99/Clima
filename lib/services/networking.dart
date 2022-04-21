import 'package:http/http.dart';
import 'dart:convert';

class networkhelper {
  networkhelper(this.url);
  String url;
  Future getdata() async {
    Response res = await get(Uri.parse(url));
    print(res.statusCode);
    if (res.statusCode == 200) {
      String data = res.body;
      return jsonDecode(data);
    } else {
      print(res.statusCode);

  }
}

// var temp = jsonDecode(data)['main']['temp'];
// var location = jsonDecode(data)['name'];
// var id = jsonDecode(data)['weather'][0]['id'];
// print(temp);
// print(id);
// print(location);
