import 'dart:convert';

import 'package:design/loover_pages/model.dart';
import 'package:design/loover_pages/model2.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class model extends StatefulWidget {
  const model({super.key});

  @override
  State<model> createState() => _modelState();
}

class _modelState extends State<model> {
  Position? cl; // curent location.
  List? x;
  Test? ttt;
  Future getData() async {
    print('at first');
    await Future.delayed(const Duration(seconds: 4), () {
      print('hi Toby');
    });
    print('then');
  }

  Future getPermetion() async {
    bool services;
    LocationPermission per;
    services = await Geolocator.isLocationServiceEnabled();
    print(services);
    if (services == false) {} // here i must to make Awesom
    per = await Geolocator.checkPermission();
    if (per == LocationPermission.denied) {
      per = await Geolocator.requestPermission();
    }
    if (per == LocationPermission.always) {
      getLatAndLong();
      print('The lat:-${cl?.altitude}');
      print('The long:-${cl?.longitude}');
    }

    print('==========================');
    print(per);
    print('==========================');
  }

  Future<Position?> getLatAndLong() async {
    return cl = await Geolocator.getCurrentPosition().then((value) => value);
  }

  Future getdataJson() async {
    // This function to gate data from json

    var res = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/posts/1"));
    var r = await jsonDecode(res.body);
    ttt = Test.fromjson(r);
    // list for put in it the data in order to show it in UI.

    print('=======================888====');
    print(x);
    print('*****************************');
  }

  /* @override
  void initState() {
    getData();
    getPermetion();
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('geolocator'),
      ),
      body: Column(
        children: [
          Container(
            child: ElevatedButton(
              onPressed: () {
                getData();
                getPermetion();
                getLatAndLong();
              },
              child: const Text('show'),
            ),
          ),
          Container(
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  getdataJson();
                });
              },
              child: const Text('show the model2 '),
            ),
          ),
          Container(
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UseresModel()));
                });
              },
              child: const Text('show the ListView'),
            ),
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 54, 52, 52),
    );
  }
}
