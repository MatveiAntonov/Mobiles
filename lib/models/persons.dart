import 'package:flutter/material.dart';
import 'package:lab1/models/person.dart';
import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:lab1/models/weather.dart';

class Persons {

  static List<Person> personsList = [];

  static Future<List<Person>> getPersons() async {
    final String response = await rootBundle.loadString('assets/store.json');
    var jsonData = await json.decode(response);

    personsList = [];
    Coordinate coordinate;
    double weather;

    for (int i = 0; i < jsonData.length; i++) {
      coordinate = Coordinate(jsonData[i]["coordinates"]["latitude"], jsonData[i]["coordinates"]["longitude"]);
      weather = await Weather.getWeather(coordinate.latitude.toString(), coordinate.longitude.toString());
      Person person = Person(jsonData[i]["id"], jsonData[i]["name"], jsonData[i]["imagePath"], coordinate, 20);
      personsList.add(person);
    }

    /*for (var p in jsonData){
      coordinate = Coordinate(p["coordinates"]["latitude"], p["coordinates"]["longitude"]);
      weather = await Weather.getWeather(coordinate.latitude.toString(), coordinate.longitude.toString());
      Person person = Person(p["id"], p["name"], p["imagePath"], coordinate, weather);
      personsList.add(person);
    }*/
    return personsList;
  }


}