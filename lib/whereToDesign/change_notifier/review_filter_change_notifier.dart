import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

import '../providers/city_provider.dart';
import '../show_information_new.dart';
import 'boat_provider_change_notifire.dart';
import 'filter_page_change_notifier.dart';
import 'search_filter_change_notifier.dart';

class ReviewFilterChangeNotifier extends ConsumerStatefulWidget {
  // List<BoatModel> filterList;

  DateTime? userTimeNow1;
  DateTime? userTimeNow2;
  ReviewFilterChangeNotifier({
    super.key,
    this.userTimeNow1,
    this.userTimeNow2,

    // required this.filterList
  });

  @override
  ConsumerState<ReviewFilterChangeNotifier> createState() => _Review2State();
}

class _Review2State extends ConsumerState<ReviewFilterChangeNotifier> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final boatListHolder = ref.watch(boatProviderChangeNotifier);
    final cityHolder = ref.watch(cityProvider);
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
                        child: Row(
                          children: [
                            TextButton(
                                onPressed: () {
                                  // Navigator.of(context).push(
                                  //   MaterialPageRoute(builder: (context) {
                                  //     return SearchFilterChangeNotifier();
                                  //   }),
                                  // );
                                  showModalBottomSheet(
                                    useSafeArea: true,
                                    // showDragHandle: true,
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) {
                                      return SearchFilterChangeNotifier();
                                    },
                                  );
                                },
                                child: Text(cityHolder.selectedCityName == null
                                    ? 'Search'
                                    : '${cityHolder.selectedCityName}')
                                //  Text(boatListHolder.selectedCityV == null
                                //     ? 'Search'
                                //     : '${boatListHolder.selectedCityV}'),
                                ),
                            Spacer(),
                            TextButton(
                              child: Text('Filter'),
                              onPressed: () {
                                showModalBottomSheet(
                                  useSafeArea: true,
                                  // showDragHandle: true,
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) {
                                    return FilterPageChangeNotifier();
                                  },
                                );
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),
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
                              itemBuilder: (_, index) => GestureDetector(
                                onTap: () {
                                  // here we will check the index and call the function getElemenIndex(){} to set the index in the provider.
                                  if (((boatListHolder.filterList == null ||
                                          boatListHolder.filterList!.isEmpty ==
                                              true) &&
                                      boatListHolder.filterValue == false)) {
                                    boatListHolder.getElemenIndex(
                                        boatListHolder.boatList[index]);
                                  } else {
                                    boatListHolder.getElemenIndex(
                                        boatListHolder.filterList![index]);
                                  }

                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return ShowInformationNew(
                                          // boatinfo:
                                          //     boatListHolder.filterListIndex,
                                          userTimeNow1: widget.userTimeNow1,
                                          userTimeNow2: widget.userTimeNow2,
                                        );
                                      },
                                    ),
                                  );
                                  // Navigator.of(context).push(
                                  //   MaterialPageRoute(
                                  //     builder: (context) {
                                  //       return ((boatListHolder.filterList ==
                                  //                       null ||
                                  //                   boatListHolder.filterList!
                                  //                           .isEmpty ==
                                  //                       true) &&
                                  //               boatListHolder.filterValue ==
                                  //                   false)
                                  //           ? ShowInformation(
                                  //               boatinfo: boatListHolder
                                  //                   .boatList![index],
                                  //               userTimeNow1:
                                  //                   widget.userTimeNow1,
                                  //               userTimeNow2:
                                  //                   widget.userTimeNow2,
                                  //             )
                                  //           : ShowInformation(
                                  //               boatinfo: boatListHolder
                                  //                   .filterList![index],
                                  //               userTimeNow1:
                                  //                   widget.userTimeNow1,
                                  //               userTimeNow2:
                                  //                   widget.userTimeNow2,
                                  //             );
                                  //     },
                                  //   ),
                                  // );
                                  setState(() {});
                                },
                                child:
                                    // CardItemView(
                                    //     items: (widget.newBoatList == null ||
                                    //             widget.newBoatList!.isEmpty)
                                    //         ? boatListHolder.boatList![index].imageList
                                    //         : widget.newBoatList![index].imageList),

                                    CardItemView(
                                        items: (boatListHolder.filterList ==
                                                    null ||
                                                boatListHolder
                                                        .filterList!.isEmpty ==
                                                    true)
                                            ? boatListHolder
                                                .boatList[index].imageList
                                            : boatListHolder
                                                .filterList![index].imageList),
                              ),
                            )
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
