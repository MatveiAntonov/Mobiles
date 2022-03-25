import 'package:lab1/models/persons.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Markers {
  static Set<Marker> markers = {};

  static Set<Marker> getMarkers() {
    markers = {};
    for (var p in Persons.personsList) {
      Marker marker = Marker(
        markerId: MarkerId(p.name),
        infoWindow: InfoWindow(
          title: p.name,
          snippet: 'Coordinates: ' + p.coordinates.latitude.toString() + p.coordinates.longitude.toString() + '; Weather: ' + p.weather.toString() + '℃'
        ),
        position: LatLng(p.coordinates.latitude, p.coordinates.longitude),
      );
      markers.add(marker);
    }
    return markers;
  }

}
