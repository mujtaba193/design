import 'package:design/whereToDesign/models/boat_model.dart';
import 'package:flutter/material.dart';

import 'change_notifier/review_filter_change_notifier.dart';
import 'new_design_slivers/pages/sliver_page.dart';
import 'show_review.dart';
import 'tickets/tickets_pages/tickets_all_pages.dart';
import 'translation/profie_page_translation.dart';
import 'yandex_map/map_view/show_all_elements_on_map.dart';

class HomePage extends StatefulWidget {
  // List<BoatModel>? searchFilterList;
  // bool searchValue;
  List<BoatModel>? newBoatList;
  DateTime? userTimeNow1;
  DateTime? userTimeNow2;
  HomePage({
    super.key,
    this.newBoatList,
    this.userTimeNow1,
    this.userTimeNow2,
    //required this.searchFilterList,
    // required this.searchValue
  });

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
      ReviewFilterChangeNotifier(),
      // ReviewFilterRiverpod(),//.................................................................>>>>
      // ReviewFilter(
      //   searchValue: widget.searchValue,
      //   searchFilterList: widget.searchFilterList,
      // ),
      // Review2(
      //   newBoatList: widget.newBoatList,
      //   userTimeNow1: widget.userTimeNow1,
      //   userTimeNow2: widget.userTimeNow2,
      //   filterList: widget.filterList,
      // ),
      // MapPage(
      //   address: [],
      // ),
      //TestPlacePicker(),
      // GoogleMampTest(),
      TicketsAllPages(),
      //NestedScrollViewExample(),
      //HeadPage(),
      // YandexPolygon(
      //   address: [],
      // ),
      // PayPage(),
      // MyHomePage(),
      // TableEvents(),
      //Loovr4(),
      // DarkModePage(),
      ShowAllElementsOnMap(),
      // ReverseSearchExample(),
      //TimerPage(),

      ////////////////// SliverBar(),
      //Val(),
      // Register3(),
      ShowReview(),
      //  UserProfile(), //.................................................................>>>
      // Loovr4(),
      // Register3(),
      //SynchronizedScrollWidget(),
      // Home(), // it was this page instead of TestPlacePicker
      //TestPlacePicker(),
      // PayPage(),
      //MyNestedScrollView(),
      SliverBar(),
      // HeadPage(),
      // TestPaymentTinkoff(),
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
