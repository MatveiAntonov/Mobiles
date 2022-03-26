import 'package:flutter/material.dart';
import 'package:lab1/models/person.dart';
import 'package:lab1/models/settings.dart';
import 'package:lab1/models/persons.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lab1/models/markers.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  double coordLat = 53.902284;
  double coordLon = 27.561831;

  String query = "";
  final inputController = TextEditingController();
  late GoogleMapController _googleMapController;
  final items = <Marker>[];

  static dynamic getStartCoordinates(double lat, double lon) {
    var _initialCameraPosition = CameraPosition(
        target: LatLng(lat, lon),
        zoom: 11.5
    );
    return  _initialCameraPosition;
}

  @override
  void initState() {
    super.initState();

    coordLat = Persons.personsList[currentPerson].coordinates.latitude;
    coordLon = Persons.personsList[currentPerson].coordinates.longitude;
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: TextField(
              controller: inputController,
              onChanged: (value) {
                query = value;
                _filterSearchResults(Markers.getMarkers().toList());
              },
              cursorColor: Colors.black,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.go,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                suffixIcon: inputController.text.isEmpty
                    ? Container(width: 0)
                    : IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => {
                    items.clear(),
                    inputController.clear(),
                    FocusScope.of(context).unfocus(),
                  },
                ),
                border: const OutlineInputBorder(
                    borderSide: BorderSide(width: 3)
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Settings.fontColor, width: 3)
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                labelText: 'Search',
                hintText: 'Some person...',
              ),
            ),
          ),
          SizedBox(
            height: items.length * 50,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => {
                    _googleMapController
                      .animateCamera(CameraUpdate.newCameraPosition(
                      CameraPosition(
                        target: items[index].position,
                        zoom: 11
                      )
                    )),
                    setState(() {
                      items.clear();
                      inputController.clear();
                    })
                  },
                  child: ListTile(
                    title: Text(
                      items[index].infoWindow.title.toString(),
                      style: TextStyle(
                        fontSize: 15 * Settings.fontCoef,
                        color: Settings.fontColor
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: GoogleMap(
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              initialCameraPosition: getStartCoordinates(coordLat, coordLon),
              onMapCreated: (controller) => _googleMapController = controller,
              markers: Markers.getMarkers(),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        onPressed: () => _googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(getStartCoordinates(coordLat, coordLon)),
        ),
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }

  void _filterSearchResults(List<Marker> markers) {
    if (query.isNotEmpty && query.length >= 3) {
      items.clear();
      setState(() {
        for (var marker in markers) {
          if (marker.infoWindow.title
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase())) {
            items.add(marker);
          }
        }
      });
    } else {
      setState(() {
        items.clear();
      });
    }
  }
}
