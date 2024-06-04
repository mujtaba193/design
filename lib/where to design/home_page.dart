import 'package:design/register%20-%20interests.dart';
import 'package:design/value.dart';
import 'package:design/where%20to%20design/pay%20pages%20/pay_page.dart';
import 'package:design/where%20to%20design/review2.dart';
import 'package:design/where%20to%20design/users_model/boat_model.dart';
import 'package:design/where%20to%20design/yandex_map.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  List<BoatModel>? newBoatList;
  DateTime? userTimeNow1;
  DateTime? userTimeNow2;
  HomePage({super.key, this.newBoatList, this.userTimeNow1, this.userTimeNow2});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BoatModel>? boatList;
  int currentIndex = 0;
  late List screens;

  @override
  void initState() {
    screens = [
      Review2(
        newBoatList: widget.newBoatList,
        userTimeNow1: widget.userTimeNow1,
        userTimeNow2: widget.userTimeNow2,
      ),
      PayPage(),
      MyHomePage(),
      // TableEvents(),
      //Loovr4(),
      Val(),
      Register3(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (int newIndex) {
          setState(() {
            currentIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: 'home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'chat',
            icon: Icon(Icons.chat),
          ),
          BottomNavigationBarItem(
            label: 'Settings',
            icon: Icon(Icons.settings),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.person),
          ),
          BottomNavigationBarItem(
            label: 'Favorite',
            icon: Icon(Icons.favorite),
          ),
        ],
      ),
    );
  }
}
