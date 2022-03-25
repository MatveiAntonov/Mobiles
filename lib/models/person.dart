import 'package:meta/meta.dart';

class Person {
  final int id;
  final String name;
  final String imagePath;
  final Coordinate coordinates;
  final double weather;

  Person(this.id, this.name, this.imagePath, this.coordinates, this.weather);
}

class Coordinate {
  final double latitude;
  final double longitude;

  Coordinate(this.latitude, this.longitude);
}