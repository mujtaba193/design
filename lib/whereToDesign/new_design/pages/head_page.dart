// import 'package:design/whereToDesign/new_design/pages/CourseFee_page.dart';
// import 'package:design/whereToDesign/new_design/pages/about_page.dart';
// import 'package:design/whereToDesign/new_design/pages/coureSyllabus_page.dart';
// import 'package:design/whereToDesign/new_design/pages/couresIntake_page.dart';
// import 'package:design/whereToDesign/new_design/pages/courseDuration_page.dart';
// import 'package:design/whereToDesign/new_design/pages/courseEligibility_page.dart';
// import 'package:design/whereToDesign/new_design/pages/entranceRequired_page.dart';
// import 'package:design/whereToDesign/new_design/pages/universityD_page.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

// const tabItem = [
//   AboutPage(),
//   CourseEligibility(),
//   CourseDuration(),
//   CouresIntake(),
//   UniversityD(),
//   EntranceRequired(),
//   CoureSyllabus(),
//   CourseFee(),

//   // Documents(),
// ];

// class HeadPage extends StatefulWidget {
//   const HeadPage({
//     required this.universityId,
//     required this.courseId,
//     super.key,
//   });

//   final int? universityId;
//   final int? courseId;

//   @override
//   State<HeadPage> createState() => _HeadPageState();
// }

// class _HeadPageState extends State<HeadPage> {
//   late ItemScrollController itemScrollController;
//   late ItemPositionsListener itemPositionsListener;
//   late TabController tabController;
//   late ScrollController scrollController;

//   bool sliverCollapsed = false;

//   bool enableScroll = false;
//   bool visibleIndexChanged = false;
//   @override
//   void initState() {
//     // TODO: implement initState
//     itemScrollController = ItemScrollController();
//     itemPositionsListener = ItemPositionsListener.create();
//     tabController = TabController(length: tabItem.length, vsync: );
//     scrollController = ScrollController();

//     itemPositionsListener.itemPositions.addListener(_itemPositionListener);

//     super.initState();
//   }

//   void _itemPositionListener() {
//     final positions = itemPositionsListener.itemPositions.value;
//     if (positions.isNotEmpty) {
//       final firstVisibleItem = positions
//           .where((ItemPosition position) => position.itemLeadingEdge >= 0)
//           .map((e) => e.index);
//       if (firstVisibleItem.isNotEmpty) {
//         // Logger.logSuccess(
//         //     'Viible Item Index ${firstVisibleItem.first} Scroll Enabled: $enableScroll Visible Index Chaned $visibleIndexChanged');
//         tabController.animateTo(firstVisibleItem.first);
//         checkSliverCollapsed(firstVisibleItem.first);
//       }
//     }
//   }

//   void checkSliverCollapsed(int index) {
//     if (index <= 1 && sliverCollapsed && visibleIndexChanged) {
//       enableScroll = false;
//       scrollController.animateTo(
//         0,
//         duration: const Duration(milliseconds: 600),
//         curve: Curves.easeOut,
//       );
//     }

//     if (index >= 2) {
//       visibleIndexChanged = true;
//     } else {
//       visibleIndexChanged = false;
//     }
//     if (scrollController.position.pixels >= kToolbarHeight) {
//       if (!sliverCollapsed) {
//         sliverCollapsed = true;
//         enableScroll = true;
//       }
//     } else {
//       if (sliverCollapsed) {}
//       sliverCollapsed = false;
//     }
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//         child: Scaffold(
//       appBar: AppBar(
//         title: Text('BSW Page'),
//       ),
//       body: NestedScrollView(
//         headerSliverBuilder: (context, innerBoxIsScrolled) => [
//           SliverAppBar(
//             elevation: 0,
//             pinned: true,
//             expandedHeight: 300,
//             floating: false,
//             stretch: true,
//             collapsedHeight: 200,
//             surfaceTintColor: Colors.white,
//             backgroundColor: Colors.white60,
//             flexibleSpace: Container(
//               height: 300,
//               //  padding: EdgeInsets.only(bottom: 3),
//               child: Image.network(
//                 'https://www.postgrad.co.uk/wp-content/uploads/2021/11/University-of-Edinburgh.jpg',
//                 fit: BoxFit.fill,
//               ),
//             ),
//             leading: CupertinoButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Icon(Icons.arrow_back_ios_sharp),
//             ),
//           ),
//         ],
//         body: LayoutBuilder(
//           builder: (BuildContext context, BoxConstraints constraints) {
//             return SizedBox(
//               height: constraints.smallest.height,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: ScrollablePositionedList.builder(
//                   semanticChildCount: tabItem.length,
//                   physics: enableScroll
//                       ? const ClampingScrollPhysics()
//                       : const NeverScrollableScrollPhysics(),
//                   itemCount: tabItem.length,
//                   itemBuilder: (context, index) {
//                     return tabItem[index];
//                   },
//                   itemScrollController: itemScrollController,
//                   itemPositionsListener: itemPositionsListener,
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     ));
//   }
// }
