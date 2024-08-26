
// import 'dart:js';

// import 'package:flutter/material.dart';

// SliverAppBar(
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