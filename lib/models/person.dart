import 'package:meta/meta.dart';

int currentPerson = 0;

class Person {
  final int id;
  final String name;
  final String imagePath;
  final Coordinate coordinates;
  double weather;

  Person(this.id, this.name, this.imagePath, this.coordinates, this.weather);
}

class Coordinate {
  final double latitude;
  final double longitude;

  Coordinate(this.latitude, this.longitude);
}