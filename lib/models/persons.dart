import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab1/models/person.dart';
import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:lab1/models/weather.dart';

class Persons {

  static List<Person> personsList = [];
  static List<Person> filteredPersons = [];

  static Future<List<Person>> getPersons() async {
    // final String response = await rootBundle.loadString('assets/store.json');
    // var jsonData = await json.decode(response);

    final QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('persons').get();
    personsList.clear();
    Coordinate coordinate;
    double weather;

    for (var p in snapshot.docs) {
      coordinate = Coordinate(p["coordinates"]["latitude"], p["coordinates"]["longitude"]);
      Person person = Person(p["id"], p["name"], p["imagePath"], coordinate, 0);
      personsList.add(person);
    }

    // for (int i = 0; i < jsonData.length; i++) {
    //   coordinate = Coordinate(jsonData[i]["coordinates"]["latitude"], jsonData[i]["coordinates"]["longitude"]);
    //   Person person = Person(jsonData[i]["id"], jsonData[i]["name"], jsonData[i]["imagePath"], coordinate, 0);
    //   personsList.add(person);
    // }

    for (var p in personsList)  {
      p.weather = await Weather.getWeather(p.coordinates.latitude.toString(), p.coordinates.longitude.toString());
    }

    if (filteredPersons.isEmpty) {
      filteredPersons = personsList;
    }
    return personsList;
  }
}

// void setWeather(Person p) async{
//   p.weather = await Weather.getWeather(p.coordinates.latitude.toString(), p.coordinates.longitude.toString());
// }