import 'package:design/loover_pages/value.dart';
import 'package:design/whereToDesign/review2.dart';
import 'package:design/whereToDesign/user_profile.dart';
import 'package:design/whereToDesign/users_model/boat_model.dart';
import 'package:flutter/material.dart';

import '../tinkoff/test_payment.dart';
import 'tickets/tickets_all_pages.dart';
import 'translation/profie_page_translation.dart';

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
      // MapPage(
      //   address: [],
      // ),
      //TestPlacePicker(),
      // GoogleMampTest(),
      TicketsAllPages(),
      // HeadPage(),
      // YandexPolygon(
      //   address: [],
      // ),
      // PayPage(),
      // MyHomePage(),
      // TableEvents(),
      //Loovr4(),

      Val(),
      // Register3(),
      UserProfile(),
      // Loovr4(),
      // Register3(),
      TestPaymentTinkoff(),
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
        items: [
          BottomNavigationBarItem(
            label: ProfiePageTranslation.home,
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: ProfiePageTranslation.chats,
            icon: Icon(Icons.chat),
          ),
          BottomNavigationBarItem(
            label: ProfiePageTranslation.settings,
            icon: Icon(Icons.settings),
          ),
          BottomNavigationBarItem(
            label: ProfiePageTranslation.profile,
            icon: Icon(Icons.person),
          ),
          BottomNavigationBarItem(
            label: ProfiePageTranslation.favorite,
            icon: Icon(Icons.favorite),
          ),
        ],
      ),
    );
  }
}
