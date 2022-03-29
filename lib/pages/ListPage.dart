import 'package:flutter/material.dart';
import 'package:lab1/main.dart';
import 'package:lab1/models/persons.dart';
import 'package:lab1/models/settings.dart';
import 'package:lab1/models/person.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final inputController = TextEditingController();
  String query = "";

  @override
  void initState() {
    super.initState();

    inputController.addListener(() => setState(() {}));
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
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: TextField(
                    controller: inputController,
                    onChanged: (value) {
                      query = value;
                      filterPersons();
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
                        onPressed: () => inputController.clear(),
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(width: 5)
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Settings.fontColor, width: 3)
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                      labelText: AppLocalizations.of(context)!.search,
                      hintText: AppLocalizations.of(context)!.find,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: Persons.filteredPersons.length,
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
                                            Persons.filteredPersons[index].name,
                                            style: TextStyle(
                                                fontSize: 26 * Settings.fontCoef,
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
                                            Persons.filteredPersons[index].coordinates.latitude.toString() + ', ' + snapshot.data[index].coordinates.longitude.toString(),
                                            style: TextStyle(
                                                fontSize: 15 * Settings.fontCoef,
                                                color: Settings.fontColor
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
                                            backgroundImage: AssetImage(Persons.filteredPersons[index].imagePath),
                                            backgroundColor: Colors.transparent,
                                            radius: 28 / Settings.fontCoef,
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.only(bottom: 5, right: 10),
                                            child: Text(
                                              Persons.filteredPersons[index].weather.toString() + '℃',
                                              style: TextStyle(
                                                  fontSize: 28 * Settings.fontCoef,
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
                            setState(() => currentPerson = index),
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Main(page: 1,)
                                )
                            )
                          },
                        );
                      }
                  ),
                ),
              ],
            );
          }
        }
      )
    );
  }

  void filterPersons() {
    if (query.isNotEmpty && query.length >= 3) {
      Persons.filteredPersons.clear();
      setState(() {
        for (var person in Persons.personsList) {
          if (person.name.toLowerCase().contains(query.toLowerCase())) {
            Persons.filteredPersons.add(person);
          }
        }
      });
    } else {
      setState(() {
        Persons.filteredPersons.clear();
        Persons.filteredPersons.addAll(Persons.personsList);
      });
    }
  }

}
