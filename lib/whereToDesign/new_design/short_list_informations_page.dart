// import 'dart:async';

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
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
// import 'package:share_plus/share_plus.dart';

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

// class CourseDetailsScreen extends StatefulWidget {
//   const CourseDetailsScreen({
//     required this.universityId,
//     required this.courseId,
//     super.key,
//   });

//   final int? universityId;
//   final int? courseId;
//   @override
//   State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
// }

// class _CourseDetailsScreenState extends State<CourseDetailsScreen>
//     with TickerProviderStateMixin {
//   late ItemScrollController itemScrollController;
//   late ItemPositionsListener itemPositionsListener;
//   late TabController tabController;
//   late ScrollController scrollController;

//   bool sliverCollapsed = false;

//   bool enableScroll = false;
//   bool visibleIndexChanged = false;
//   Timer? debounce;

//   @override
//   void initState() {
//     itemScrollController = ItemScrollController();
//     itemPositionsListener = ItemPositionsListener.create();
//     tabController = TabController(length: tabItem.length, vsync: this);
//     scrollController = ScrollController();

//     itemPositionsListener.itemPositions.addListener(_itemPositionListener);

//     // context.read<CourseDetailsBloc>()
//     //   ..add(
//     //     CheckCourseSaved(
//     //       leadId: context.currentUser?.id,
//     //       courseId: widget.courseId,
//     //     ),
//     //   )
//     //   ..add(
//     //     FetchCourseDetails(
//     //       courseId: widget.courseId,
//     //       universityId: widget.universityId,
//     //     ),
//     //   );

//     // Logger.logWarning('UNIVERSITY ID: ${widget.universityId}');

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

//   void scrollToIndex(int index) async {
//     await itemScrollController.scrollTo(
//       index: index,
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
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
//   void dispose() {
//     itemPositionsListener.itemPositions.removeListener(_itemPositionListener);

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       onPopInvoked: (didPop) {
//         if (didPop) {
//           context.read<CourseDetailsBloc>().add(const ClearCourseDetails());
//         }
//       },
//       child: Scaffold(
//         body: BlocBuilder<CourseDetailsBloc, CourseDetailsState>(
//           builder: (context, state) {
//             if (state.successOption.isSome() && !state.loading) {
//               return NestedScrollView(
//                 controller: scrollController,
//                 headerSliverBuilder: (context, innerBoxIsScrolled) => [
//                   SliverAppBar(
//                     backgroundColor: ColorResources.WHITE,
//                     surfaceTintColor: ColorResources.WHITE,
//                     floating: false,
//                     stretch: true,
//                     collapsedHeight: 200,
//                     leading: CupertinoButton(
//                       onPressed: () {
//                         context
//                             .read<CourseDetailsBloc>()
//                             .add(const ClearCourseDetails());
//                         Navigator.pop(context);
//                       },
//                       padding: EdgeInsets.zero,
//                       child: SvgPicture.asset(
//                         Assets.icon.eventbackbutton.keyName,
//                       ),
//                     ),
//                     elevation: 0,
//                     pinned: true,
//                     expandedHeight: 400,
//                     flexibleSpace: Container(
//                       padding: const EdgeInsets.only(bottom: 100),
//                       height: 400,
//                       child: CustomCachedNetworkImage(
//                         url: universityImage.trim(),
//                       ),
//                     ),
//                     bottom: PreferredSize(
//                       preferredSize: const Size.fromHeight(80),
//                       child: CourseSliverAppBarBottom(
//                         silverCollapsed: sliverCollapsed,
//                         tabController: tabController,
//                         courseDetails: state.courseDetails!,
//                         onTabClicked: (index) {
//                           scrollToIndex(index);
//                         },
//                       ),
//                     ),
//                     actions: [
//                       CupertinoButton(
//                         pressedOpacity: 0.8,
//                         padding: EdgeInsets.zero,
//                         onPressed: () {
//                           context.read<CourseDetailsBloc>().add(
//                                 AddOrRemoveCourseFromSavedCourse(
//                                   context.currentUser?.id,
//                                 ),
//                               );
//                         },
//                         child: SvgPicture.asset(
//                           state.saved
//                               ? Assets.icon.savedIcon.keyName
//                               : Assets.icon.saveButtonIcon.keyName,
//                         ),
//                       ),
//                       CupertinoButton(
//                         padding: EdgeInsets.zero,
//                         onPressed: () async {
//                           await Share.share(
//                             'checkout this Course :https://test.gslstudent.lilacinfotech.com/find?universityId=${widget.universityId}&courseId=${widget.courseId}',
//                             subject: 'checkout this University',
//                           );
//                         },
//                         child: SvgPicture.asset(
//                           Assets.icon.shareButtonIcon.keyName,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//                 body: LayoutBuilder(
//                   builder: (context, constraints) => SizedBox(
//                     height: constraints.smallest.height,
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       child: ScrollablePositionedList.builder(
//                         semanticChildCount: tabItem.length,
//                         physics: enableScroll
//                             ? const ClampingScrollPhysics()
//                             : const NeverScrollableScrollPhysics(),
//                         itemCount: tabItem.length,
//                         itemBuilder: (context, index) {
//                           return tabItem[index];
//                         },
//                         itemScrollController: itemScrollController,
//                         itemPositionsListener: itemPositionsListener,
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             } else if (state.failureOption.isSome() && !state.loading) {
//               return CommonWidgets.errorReload('', callback: () {});
//             } else {
//               return const SizedBox(
//                 child: Center(
//                   child: CustomCircularProgressIndicator(),
//                 ),
//               );
//             }
//           },
//         ),
//         bottomNavigationBar: BlocBuilder<CourseDetailsBloc, CourseDetailsState>(
//           builder: (context, state) {
//             return state.showButton
//                 ? SafeArea(
//                     child: Padding(
//                       padding: const EdgeInsets.only(
//                           left: 16, right: 16, bottom: 16),
//                       child: SubmitButton.primary(
//                         "Shortlist Course",
//                         showLoader: state.loading,
//                         onTap: (value) {
//                           context.read<CourseDetailsBloc>().add(
//                                 ShortListCourse(
//                                   context.currentUser?.id,
//                                 ),
//                               );
//                         },
//                       ),
//                     ),
//                   )
//                 : const SizedBox();
//           },
//         ),
//       ),
//     );
//   }
// }

// const tabs = [
//   'About',
//   'Eligibility',
//   'Course Duration',
//   'Course Intake',
//   'University',
//   'Entrance Required',
//   'Course Syllabus',
//   'Fee Strecture',
//   // 'Documents'
// ];

// class CourseSliverAppBarBottom extends StatelessWidget {
//   const CourseSliverAppBarBottom({
//     super.key,
//     required this.courseDetails,
//     required this.silverCollapsed,
//     required this.tabController,
//     required this.onTabClicked,
//   });

//   final bool silverCollapsed;
//   final TabController tabController;
//   final CourseDetails courseDetails;
//   final void Function(int) onTabClicked;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           height: 100,
//           width: MediaQuery.sizeOf(context).width,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.vertical(
//               top: Radius.circular(
//                 silverCollapsed ? 16 : 0,
//               ),
//             ),
//           ),
//           child: Padding(
//             padding:
//                 const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 10),
//             child: Row(
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       width: 330,
//                       child: Text(
//                         "${courseDetails.courseName}".capitalize,
//                         style: h4.black,
//                         // overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 16,
//                     ),
//                     IconTextCenter(
//                       text: '${courseDetails.universityName?.capitalize}',
//                       icon: Assets.icon.universityiconmini.keyName,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Container(
//           width: double.infinity,
//           color: Colors.white,
//           child: UniversityTabbar(
//             tabs: tabs,
//             tabController: tabController,
//             onTabClicked: onTabClicked,
//           ),
//         ),
//       ],
//     );
//   }
// }

// class UniversityTabbar extends StatelessWidget implements PreferredSize {
//   const UniversityTabbar({
//     required this.tabController,
//     required this.tabs,
//     required this.onTabClicked,
//     super.key,
//   });
//   final List<String> tabs;
//   final TabController tabController;
//   final void Function(int) onTabClicked;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Theme(
//         data: ThemeData(useMaterial3: false),
//         child: Stack(
//           fit: StackFit.passthrough,
//           alignment: Alignment.bottomCenter,
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                 vertical: 9,
//               ),
//               child: Container(
//                 decoration: const BoxDecoration(
//                   border: Border(
//                     bottom: BorderSide(color: ColorResources.GREY4, width: 2.0),
//                   ),
//                 ),
//               ),
//             ),
//             TabBar(
//               unselectedLabelStyle: body2,
//               onTap: onTabClicked,
//               automaticIndicatorColorAdjustment: true,

//               // indicator: BoxDecoration(),
//               controller: tabController,
//               unselectedLabelColor: ColorResources.BLACKGREY,
//               indicatorColor: ColorResources.SECONDARY,
//               labelColor: ColorResources.SECONDARY,
//               indicatorPadding:
//                   const EdgeInsets.symmetric(vertical: 9, horizontal: 12),
//               // labelStyle: heading1.secondary,

//               // controller: ,
//               isScrollable: true,
//               tabs: List.generate(
//                   tabs.length,
//                   // universityTabTiles.length,
//                   (index) => Tab(text: tabs[index])),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget get child => this;

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }
