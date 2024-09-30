import 'package:design/whereToDesign/models/boat_model.dart';
import 'package:design/whereToDesign/show_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

import '../filter/filter_page.dart';
import '../filter/search_filter.dart';
import '../providers/bout_provider.dart';

class ReviewFilterRiverpod extends ConsumerStatefulWidget {
  // List<BoatModel> filterList;
  bool searchValue;
  List<BoatModel>? searchFilterList;
  DateTime? userTimeNow1;
  DateTime? userTimeNow2;
  ReviewFilterRiverpod(
      {super.key,
      this.userTimeNow1,
      this.userTimeNow2,
      this.searchFilterList,
      required this.searchValue
      // required this.filterList
      });

  @override
  ConsumerState<ReviewFilterRiverpod> createState() => _Review2State();
}

class _Review2State extends ConsumerState<ReviewFilterRiverpod> {
  // double startPrice = 1;
  // double endPrice = 10000;
  // double startLength = 1;
  // double endLength = 10000;
  // double startRating = 1;
  // double endRating = 5;
  // int? shipType;
  // int? toilet;
  // bool? rainValue;
  // bool? bimini;
  // bool? bluetooth;
  // bool? mask;
  // bool? shower;
  // bool? fridge;
  // bool? blankets;
  // bool? table;
  // bool? glasses;
  // bool? bathing;
  // bool? fishEcho;
  // bool? heater;
  // bool? climate;

  // List<String> list = [
  //   FilterPageTranslation.highspeed,
  //   FilterPageTranslation.american,
  //   FilterPageTranslation.slowMoving,
  //   FilterPageTranslation.retro,
  //   FilterPageTranslation.closed,
  //   FilterPageTranslation.withFlybridge,
  //   FilterPageTranslation.withPanoramicWindows
  // ];
  // List<String> selectedlist = [];
  // List<BoatModel>? filterList;
  // String? theShipTypeValue;
  // String? theToiletValue;
  // bool filterValue = false;
  @override
  void initState() {
    filter();
    super.initState();
  }

  filter() {
    final boatListHolder = ref.read(boutProvider);
    boatListHolder.filter(widget.searchFilterList);
  }

  @override
  Widget build(BuildContext context) {
    final boatListHolder = ref.read(boutProvider);
    final boatList = boatListHolder.boatList;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        body: FutureBuilder(
            future: boatListHolder.readJsondata(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                          height: 60,
                          margin: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF8942BC),
                                Color(0xFF5831F7),
                                Color(0xFF5731F8),
                                Color(0xFF00C2C2),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child:
                              // (filterList == null)
                              //     ?
                              Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) {
                                      return SearchFilter(
                                          boatList: boatListHolder.boatList);
                                    }),
                                  );
                                },
                                child: Text('Search'),
                              ),
                              Spacer(),
                              TextButton(
                                child: Text('Filter'),
                                onPressed: () {
                                  showModalBottomSheet(
                                    useSafeArea: true,
                                    // showDragHandle: true, // we can get the price from the model boatListHolder.boatList![index].finalPrice
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) {
                                      return FilterPage(
                                        searchFilterList:
                                            (boatListHolder.filterList ==
                                                        null ||
                                                    boatListHolder.filterList!
                                                            .isEmpty ==
                                                        true)
                                                ? boatListHolder.boatList!
                                                : boatListHolder.filterList!,
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          )
                          // : Row(
                          //     children: [
                          //       TextButton(
                          //           onPressed: () {
                          //             Navigator.of(context).push(
                          //               MaterialPageRoute(builder: (context) {
                          //                 return WhereTo(
                          //                     boatList:
                          //                         boatListHolder.boatList);
                          //               }),
                          //             );
                          //           },
                          //           child: Text('Search')),
                          //       Spacer(),
                          //       TextButton(
                          //         onPressed: () {
                          //           setState(() {
                          //             //    widget.newBoatList = null;
                          //             // widget.newBoatList = [];
                          //             // widget.filterList = null;
                          //             filterList = [];
                          //             filterValue = false;
                          //             filterList = null;
                          //           });
                          //         },
                          //         child: Text('Rreset'),
                          //       ),
                          //     ],
                          //   ),
                          ),
                      // ((widget.searchFilterList == null ||
                      //             widget.searchFilterList!.isEmpty == true) &&
                      //         widget.searchValue == true)
                      //     ? Text('No result found')
                      //     : ((widget.searchFilterList == null ||
                      //                 widget.searchFilterList!.isEmpty ==
                      //                     true) &&
                      //             (widget.searchValue == false))
                      //         ?
                      ((boatListHolder.filterList == null ||
                                  boatListHolder.filterList!.isEmpty == true) &&
                              boatListHolder.filterValue == true)
                          ? Text('No result found')
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: (boatListHolder.filterList == null ||
                                      boatListHolder.filterList!.isEmpty ==
                                          true)
                                  ? boatListHolder.boatList!.length
                                  : boatListHolder.filterList!.length,

                              // here it was boatList!.length
                              itemBuilder: (_, index) => GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return ((boatListHolder.filterList ==
                                                        null ||
                                                    boatListHolder.filterList!
                                                            .isEmpty ==
                                                        true) &&
                                                boatListHolder.filterValue ==
                                                    false)
                                            ? ShowInformation(
                                                boatinfo: boatListHolder
                                                    .boatList![index],
                                                userTimeNow1:
                                                    widget.userTimeNow1,
                                                userTimeNow2:
                                                    widget.userTimeNow2,
                                              )
                                            : ShowInformation(
                                                boatinfo: boatListHolder
                                                    .filterList![index],
                                                userTimeNow1:
                                                    widget.userTimeNow1,
                                                userTimeNow2:
                                                    widget.userTimeNow2,
                                              );

                                        /* return ShowInformation(
                                    boatList: widget.newBoatList![
                                        index]); */ // here it was boatList![index]
                                      },
                                    ),
                                  );
                                },
                                child:
                                    // CardItemView(
                                    //     items: (widget.newBoatList == null ||
                                    //             widget.newBoatList!.isEmpty)
                                    //         ? boatListHolder.boatList![index].imageList
                                    //         : widget.newBoatList![index].imageList),

                                    CardItemView(
                                        items: ((boatListHolder.filterList ==
                                                        null ||
                                                    boatListHolder.filterList!
                                                            .isEmpty ==
                                                        true) &&
                                                boatListHolder.filterValue ==
                                                    false)
                                            ? boatListHolder
                                                .boatList![index].imageList
                                            : boatListHolder
                                                .filterList![index].imageList),
                              ),
                            )
                      // : ListView.builder(
                      //     shrinkWrap: true,
                      //     physics: NeverScrollableScrollPhysics(),
                      //     itemCount: widget.searchFilterList!.length,

                      //     // here it was boatList!.length
                      //     itemBuilder: (_, index) => GestureDetector(
                      //       onTap: () {
                      //         Navigator.of(context).push(
                      //           MaterialPageRoute(
                      //             builder: (context) {
                      //               return ShowInformation(
                      //                 boatinfo: widget
                      //                     .searchFilterList![index],
                      //                 userTimeNow1: widget.userTimeNow1,
                      //                 userTimeNow2: widget.userTimeNow2,
                      //               );

                      //               /* return ShowInformation(
                      //       boatList: widget.newBoatList![
                      //           index]); */ // here it was boatList![index]
                      //             },
                      //           ),
                      //         );
                      //       },
                      //       child:
                      //           // CardItemView(
                      //           //     items: (widget.newBoatList == null ||
                      //           //             widget.newBoatList!.isEmpty)
                      //           //         ? boatListHolder.boatList![index].imageList
                      //           //         : widget.newBoatList![index].imageList),

                      //           CardItemView(
                      //               items: widget
                      //                   .searchFilterList![index]
                      //                   .imageList),
                      //     ),
                      //   ),
                    ],
                  ),
                );
              }
            }));
  }
}

class CardItemView extends StatelessWidget {
  const CardItemView({super.key, required this.items});
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          //imagePArt here
          Container(
            decoration: BoxDecoration(
              // color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: const GradientBoxBorder(
                width: 2,
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF8942BC),
                    Color(0xFF5831F7),
                    Color(0xFF5731F8),
                    Color(0xFF00C2C2),
                  ],
                ),
              ),
            ),
            width: MediaQuery.of(context).size.width * 0.97,
            //height: MediaQuery.of(context).size.height / 2.5,
            child: ImageSliderView(
              imagesPath: items,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class ImageSliderView extends StatefulWidget {
  const ImageSliderView({
    super.key,
    this.imageHeight = 200.0,
    required this.imagesPath,
  });
  //get imageURLs
  final double imageHeight; // or use aspect ratio
  final List<String> imagesPath;

  @override
  State<ImageSliderView> createState() => _ImageSliderViewState();
}

class _ImageSliderViewState extends State<ImageSliderView> {
  int _current = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _current = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final counterView = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < widget.imagesPath.length; i++)
          Container(
            width: 8.0,
            height: 8.0,
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _current == i ? Colors.blue : Colors.grey,
            ),
          ),
      ],
    );
    return SizedBox(
      height: widget.imageHeight,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Stack(
        children: [
          Positioned.fill(
            child: PageView.builder(
                itemCount: widget.imagesPath.length,
                controller: _pageController,
                itemBuilder: (context, index) => ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        widget.imagesPath[index],
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      ),
                    )
                // CachedNetworkImage(imageUrl: widget.imagesPath.toString()),
                ),
          ),
          Positioned(
            bottom: 8,
            left: 0,
            right: 0,
            child: counterView,
          ),
        ],
      ),
    );
  }
}