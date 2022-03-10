import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:web/image_list.dart';
import 'package:web/image_model.dart';
import 'package:web/option_menu.dart';

List<ImageModel> attractions = [];

List<ImageModel> curr = [];

class HomeScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<HomeScreen> {
  List<ImageModel> images = [];

  String city = "City";
  String restaurant = "Restaurant";
  String shopping = "Shopping";
  String museum = "Museum";
  String nature = "Nature";
  String cost = "Price";

  void fetchImage() async {
    final String response = await rootBundle.loadString('ga.json');
    final data = await json.decode(response) as List<dynamic>;
    var x = data.map((e) => ImageModel.fromJson(e)).toList();
    attractions = x;

    setState(() {
      images.addAll(x);
      curr.addAll(x);
    });
  }

  // Filters the list by using a "where" condition, MATCHING the array objects
  // Updates State of the Home Screen
  void filterList() {
    List<ImageModel> filteredList = images.where((attraction) {
      return ((attraction.city == city || city == "City") &&
          (attraction.restaurant == restaurant || restaurant == "Restaurant") &&
          (attraction.shopping == shopping || shopping == "Shopping") &&
          (attraction.museum == museum || museum == "Museum") &&
          (attraction.cost == cost || cost == "Price") &&
          (attraction.nature == nature || nature == "Nature"));
    }).toList();
    setState(() {
      curr = filteredList;
    });
  }

  @override
  void initState() {
    // TODO: implement initStateR
    super.initState();
    fetchImage();
  }

  @override
  // Creates the Widgets for SHOWING the CARDS
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Georgia Travels"),
        ),
        // Adds Floating Action Button - Search Capability
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Stack(
                      children: <Widget>[
                        Positioned(
                          left: -40.0,
                          top: -40.0,
                          child: InkResponse(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: CircleAvatar(
                              child: Icon(Icons.close, color: Colors.blueGrey),
                              backgroundColor: Colors.grey,
                            ),
                          ),
                        ),
                        Form(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text("Filters"),
                              OptionWidget(
                                type: city,
                                options: attractions
                                    .map((e) => e.city)
                                    .toSet()
                                    .toList(),
                                onSelect: (String value) {
                                  print(value);
                                  city = value;
                                },
                              ),
                              Padding(
                                padding: EdgeInsets.all(12),
                                child: OptionWidget(
                                    type: restaurant,
                                    options: ["Yes", "No"],
                                    onSelect: (String value) {
                                      restaurant = value;
                                    }),
                              ),
                              Padding(
                                  padding: EdgeInsets.all(12),
                                  child: OptionWidget(
                                      type: shopping,
                                      options: ["Yes", "No"],
                                      onSelect: (String value) {
                                        shopping = value;
                                      })),
                              Padding(
                                  padding: EdgeInsets.all(12),
                                  child: OptionWidget(
                                      type: museum,
                                      options: ["Yes", "No"],
                                      onSelect: (String value) {
                                        museum = value;
                                      })),
                              Padding(
                                  padding: EdgeInsets.all(12),
                                  child: OptionWidget(
                                      type: nature,
                                      options: ["Yes", "No"],
                                      onSelect: (String value) {
                                        nature = value;
                                      })),
                              Padding(
                                  padding: EdgeInsets.all(12),
                                  child: OptionWidget(
                                      type: cost,
                                      options: ["Free", r"$", r"$$", r"$$$"],
                                      onSelect: (String value) {
                                        cost = value;
                                      })),
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    child: Text("Search"),
                                    onPressed: () {
                                      filterList();
                                      Navigator.pop(context);
                                    },
                                  )),
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    child: Text("Clear"),
                                    onPressed: () {
                                      setState(() {
                                        city = "City";
                                        restaurant = "Restaurant";
                                        shopping = "Shopping";
                                        museum = "Museum";
                                        nature = "Nature";
                                        cost = "Price";
                                      });
                                      filterList();
                                      Navigator.pop(context);
                                    },
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                });
          },
          backgroundColor: Colors.blue,
          child: const Icon(Icons.search),
        ),
        body: Container(
            alignment: Alignment.center,
            child: Column(children: [
              Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 20)),
              const Text("Top Attractions",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 20)),
              Container(
                child: ImageList(curr),
                width: 1000,
                height: 660,
              )
            ])));
  }
}
