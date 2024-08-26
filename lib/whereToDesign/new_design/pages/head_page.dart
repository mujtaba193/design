import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'CourseFee_page.dart';
import 'about_page.dart';
import 'coureSyllabus_page.dart';
import 'couresIntake_page.dart';
import 'courseDuration_page.dart';
import 'courseEligibility_page.dart';
import 'entranceRequired_page.dart';
import 'universityD_page.dart';

const tabItem = [
  AboutPage(),
  CourseEligibility(),
  CourseDuration(),
  CouresIntake(),
  UniversityD(),
  EntranceRequired(),
  CoureSyllabus(),
  CourseFee(),

  // Documents(),
];

class HeadPage extends StatefulWidget {
  const HeadPage({super.key});

//  final int? universityId;
  // final int? courseId;

  @override
  State<HeadPage> createState() => _HeadPageState();
}

class _HeadPageState extends State<HeadPage> {
  late ItemScrollController itemScrollController;
  late ItemPositionsListener itemPositionsListener;
  late TabController tabController;
  //late ScrollController scrollController;

  bool sliverCollapsed = false;

  bool enableScroll = false;
  bool visibleIndexChanged = false;
  @override
  void initState() {
    // TODO: implement initState
    itemScrollController = ItemScrollController();
    itemPositionsListener = ItemPositionsListener.create();
    //  tabController = TabController(length: tabItem.length, vsync: );
    // scrollController = ScrollController();

    // itemPositionsListener.itemPositions.addListener(_itemPositionListener);

    super.initState();
  }

  // void _itemPositionListener() {
  //   final positions = itemPositionsListener.itemPositions.value;
  //   if (positions.isNotEmpty) {
  //     final firstVisibleItem = positions
  //         .where((ItemPosition position) => position.itemLeadingEdge >= 0)
  //         .map((e) => e.index);
  //     if (firstVisibleItem.isNotEmpty) {
  //       // Logger.logSuccess(
  //       //     'Viible Item Index ${firstVisibleItem.first} Scroll Enabled: $enableScroll Visible Index Chaned $visibleIndexChanged');
  //       tabController.animateTo(firstVisibleItem.first);
  //       checkSliverCollapsed(firstVisibleItem.first);
  //     }
  //   }
  // }

  // void checkSliverCollapsed(int index) {
  //   if (index <= 1 && sliverCollapsed && visibleIndexChanged) {
  //     enableScroll = false;
  //     scrollController.animateTo(
  //       0,
  //       duration: const Duration(milliseconds: 600),
  //       curve: Curves.easeOut,
  //     );
  //   }

  //   if (index >= 2) {
  //     visibleIndexChanged = true;
  //   } else {
  //     visibleIndexChanged = false;
  //   }
  //   if (scrollController.position.pixels >= kToolbarHeight) {
  //     if (!sliverCollapsed) {
  //       sliverCollapsed = true;
  //       enableScroll = true;
  //     }
  //   } else {
  //     if (sliverCollapsed) {}
  //     sliverCollapsed = false;
  //   }
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    final List<String> tabs = <String>['Tab 1', 'Tab 2'];
    return PopScope(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                forceElevated: innerBoxIsScrolled,
                floating: false,
                stretch: true,
                centerTitle: false,
                scrolledUnderElevation: 100,
                title: Text(
                  'sliver app bar',
                  style: TextStyle(color: Colors.black, fontSize: 50),
                ),

                elevation: 100,
                pinned: true,
                expandedHeight: 300,

                toolbarHeight: 40,
                collapsedHeight: 40,
                surfaceTintColor: Colors.red,
                backgroundColor: Colors.white30,
                flexibleSpace: Container(
                  height: 400,
                  //  padding: EdgeInsets.only(bottom: 3),
                  child: Image.network(
                    'https://www.postgrad.co.uk/wp-content/uploads/2021/11/University-of-Edinburgh.jpg',
                    fit: BoxFit.fill,
                  ),
                ),
                leading: CupertinoButton(
                  onPressed: () {
                    // Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.red,
                  ),
                ),
                //
              ),
            ),
          ],
          body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return SizedBox(
                height: constraints.biggest.height,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ScrollablePositionedList.builder(
                    semanticChildCount: tabItem.length,
                    physics: enableScroll
                        ? const ClampingScrollPhysics()
                        : const NeverScrollableScrollPhysics(),
                    itemCount: tabItem.length,
                    itemBuilder: (context, index) {
                      return TabBarView(
                        children: [
                          AboutPage(),
                          CourseEligibility(),
                          CourseDuration(),
                          CouresIntake(),
                          UniversityD(),
                          EntranceRequired(),
                          CoureSyllabus(),
                          CourseFee(),
                          // Documents(),
                        ],
                      );
                      //  return tabItem[index];
                    },
                    itemScrollController: itemScrollController,
                    itemPositionsListener: itemPositionsListener,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
