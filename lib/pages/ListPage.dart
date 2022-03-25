import 'package:flutter/material.dart';
import 'package:lab1/models/persons.dart';
import 'package:lab1/models/settings.dart';
import 'package:lab1/models/weather.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {

  @override
  void initState() {
    super.initState();

    Persons.getPersons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Persons.getPersons(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    child: Container(
                      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.redAccent,
                      ),
                      height: 99,
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10, top: 10),
                                    child: Text(
                                      snapshot.data[index].name,
                                      style: TextStyle(
                                          fontSize: 25 * Settings.fontCoef,
                                          color: Settings.fontColor,
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                                    child: Text(
                                      snapshot.data[index].coordinates.latitude.toString() + ', ' + snapshot.data[index].coordinates.longitude.toString(),
                                      style: TextStyle(
                                          fontSize: 18 * Settings.fontCoef,
                                          color: Colors.black
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: CircleAvatar(
                                      backgroundImage: AssetImage(snapshot.data[index].imagePath),
                                      backgroundColor: Colors.transparent,
                                      radius: 27 / Settings.fontCoef,
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(bottom: 5, right: 10),
                                      child: Text(
                                        snapshot.data[index].weather.toString() + '℃',
                                        style: TextStyle(
                                            fontSize: 30 * Settings.fontCoef,
                                            color: Settings.fontColor
                                        ),
                                      )
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                    ),
                     onTap: () => {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const Main(page: 1,))
                      // )
                       //Weather.getWeather(snapshot.data[index].coordinates.latitude.toString(), snapshot.data[index].coordinates.longitude.toString())
                     },
                  );
                }
            );
          }
        }
      )
    );
  }
}
