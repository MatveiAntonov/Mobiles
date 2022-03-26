import 'package:http/http.dart' as http;
import 'dart:convert';

class Weather {
  static Future<double> getWeather(String lat, String lon) async {
  //  https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
    double degr = 0;

    final queryParameters = {'lat': lat, 'lon': lon, 'units': 'metric', 'appid': '229869b5ccd832c63a4e74171b0e0b32'};
    final uri = Uri.https('api.openweathermap.org', '/data/2.5/weather', queryParameters);
    final response = await http.get(uri);
    final jsonData = json.decode(response.body);
    degr = jsonData["main"]["temp"];
    return degr;
  }
}