import 'package:design/appconfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:readmore/readmore.dart';

import '../../models/all_reviews_model.dart';
import '../../providers/all_reviews_provider.dart';
import '../../show_all_reviews.dart';
import '../tickets_provider_folder/tickets_application_future_provider.dart';
import 'tickets_review_page.dart';

class TicketBeforeToday extends ConsumerStatefulWidget {
  const TicketBeforeToday({super.key});

  @override
  ConsumerState<TicketBeforeToday> createState() => _TicketBeforTodayState();
}

class _TicketBeforTodayState extends ConsumerState<TicketBeforeToday> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theHolder = ref.watch(ticketApplicationFutureProvider);
    final reviewHolder = ref.watch(allReviewsProvider);

    return Scaffold(
      body: Consumer(builder: (context, ref, _) {
        return SingleChildScrollView(
          child: Column(
            children: [
              theHolder.when(
                data: (list) {
                  return Column(
                    children: [
                      ...list
                          .map(
                            (element) => Padding(
                              padding: const EdgeInsets.all(8),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppConfig.cardColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        CardItemView(
                                          items: element.photos,
                                        ),
                                        Positioned(
                                          right: 10,
                                          top: 10,
                                          child: IconButton(
                                            onPressed: () {},
                                            // the Icon of favorite button.
                                            icon: SvgPicture.asset(
                                                'assets/Heart 2.svg'),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'ID  ${element.id}',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w300,
                                                color: AppConfig.fontColor2),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                '${element.name}',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppConfig.fontColor),
                                              ),
                                              Spacer(),
                                              Icon(
                                                size: 10,
                                                Icons.circle,
                                                color: element.status ==
                                                        'Confirmed'
                                                    ? Color(0XFF19AE7A)
                                                    : Colors.yellow,
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              // guest Icon.
                                              SvgPicture.asset(
                                                  'assets/Group 3.svg'),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                ' Up to ${element.guests} ',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w300,
                                                    color:
                                                        AppConfig.fontColor2),
                                              ),
                                              Text(
                                                '${element.guests < 2 ? 'guest' : 'guests'}',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w300,
                                                    color:
                                                        AppConfig.fontColor2),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              GestureDetector(
                                                onTap: () {},
                                                // like Icon.
                                                child: SvgPicture.asset(
                                                    'assets/Star.svg'),
                                              ),
                                              SizedBox(
                                                width: 16,
                                              ),
                                              Text(
                                                '${element.rating == null ? '0' : element.rating}',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w300,
                                                    color:
                                                        AppConfig.fontColor2),
                                              ),
                                              SizedBox(
                                                width: 16,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  List<ReviewssModel>
                                                      reviewsList = [];
                                                  reviewHolder.whenData((e) {
                                                    // Filter the boat reviews based on the boatId
                                                    var filteredBoatReviews = e
                                                        .boatReviews
                                                        .where((boat) =>
                                                            boat.boatId ==
                                                            element.boatId)
                                                        .toList();
                                                    // Extract the reviews and make sure they are of the correct type (ReviewssModel)
                                                    List<ReviewssModel>
                                                        reviewValue =
                                                        filteredBoatReviews
                                                            .expand((element) =>
                                                                element.reviews)
                                                            .toList();

                                                    // Add the reviews to the reviewsList
                                                    reviewsList
                                                        .addAll(reviewValue);
                                                  });
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) {
                                                        return ShowAllReviews(
                                                          reviewsList:
                                                              reviewsList,
                                                        );
                                                      },
                                                    ),
                                                  );
                                                },
                                                // Review Icon.
                                                child: SvgPicture.asset(
                                                    'assets/Message 29.svg'),
                                              ),
                                              SizedBox(
                                                width: 16,
                                              ),
                                              Consumer(builder:
                                                  (BuildContext context, ref,
                                                      _) {
                                                return reviewHolder.when(
                                                    data: (e) {
                                                  // Filter the boat reviews based on the boatId
                                                  var filteredBoatReviews = e
                                                      .boatReviews
                                                      .where((boat) =>
                                                          boat.boatId ==
                                                          element.boatId)
                                                      .toList();
                                                  // Extract the reviews and make sure they are of the correct type (ReviewssModel)
                                                  List<ReviewssModel>
                                                      reviewValue =
                                                      filteredBoatReviews
                                                          .expand((element) =>
                                                              element.reviews)
                                                          .toList();
                                                  return Text(
                                                    reviewValue.length
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      decoration: TextDecoration
                                                          .underline,
                                                      color:
                                                          AppConfig.fontColor2,
                                                    ),
                                                  );
                                                }, error: (Object error,
                                                        StackTrace stackTrace) {
                                                  return SizedBox();
                                                }, loading: () {
                                                  return CircularProgressIndicator();
                                                });
                                              })
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Divider(
                                            color: AppConfig.fontColor2
                                                .withOpacity(0.25),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              // location Icon.
                                              SvgPicture.asset(
                                                  'assets/Ellipse 83.svg'),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Text(
                                                '${element.startAddress.name}',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w300,
                                                    color: AppConfig.fontColor),
                                              ),
                                              Spacer(),
                                              if (element.startAddress.name ==
                                                  element.destination.name)
                                                Icon(
                                                  Icons.refresh,
                                                  color:
                                                      const Color(0xff2296B7),
                                                )
                                            ],
                                          ),
                                          element.startAddress.name ==
                                                  element.destination.name
                                              ? SizedBox()
                                              : Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SvgPicture.asset(
                                                        'assets/Frame 31.svg'),
                                                    Row(
                                                      children: [
                                                        //destination Icon.
                                                        SvgPicture.asset(
                                                            'assets/Ellipse 83.svg'),
                                                        SizedBox(
                                                          width: 15,
                                                        ),
                                                        Text(
                                                          '${element.destination.name}',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              color: AppConfig
                                                                  .fontColor),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Divider(
                                            color: AppConfig.fontColor2
                                                .withOpacity(0.25),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  //Clock Icon.
                                                  SvgPicture.asset(
                                                      'assets/Clock Circle.svg'),
                                                  SizedBox(
                                                    width: 16,
                                                  ),
                                                  Text(
                                                    '${element.startTime.day < 10 ? '0${element.startTime.day}' : element.startTime.day}.${element.startTime.month < 10 ? '0${element.startTime.month}' : element.startTime.month} ${element.startTime.hour < 10 ? '0 ${element.startTime.hour}' : element.startTime.hour}:${element.startTime.minute < 10 ? '0${element.startTime.minute}' : element.startTime.minute} - ${element.endTime.day < 10 ? '0${element.endTime.day}' : element.endTime.day}.${element.endTime.month < 10 ? '0${element.endTime.month}' : element.endTime.month} ${element.endTime.hour < 10 ? '0 ${element.endTime.hour}' : element.endTime.hour}:${element.endTime.minute < 10 ? '0${element.endTime.minute}' : element.endTime.minute}',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        color: AppConfig
                                                            .fontColor),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    '${element.price} R',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          AppConfig.iconColor2,
                                                    ),
                                                  ),
                                                  Text(
                                                    ' /  2 hour',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: AppConfig
                                                            .fontColor),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              element.rating == null
                                                  ? GestureDetector(
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .push(
                                                          MaterialPageRoute(
                                                            builder: (context) {
                                                              return TicketsReviewPage();
                                                            },
                                                          ),
                                                        );
                                                      },
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        height: 48,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            color: Color(
                                                                0XFF19AE7A)),
                                                        child: Center(
                                                          child: Text(
                                                            'Leave feedback ',
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: AppConfig
                                                                    .cardColor),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : Consumer(
                                                      builder:
                                                          (BuildContext context,
                                                              ref, _) {
                                                        return reviewHolder
                                                            .when(data: (e) {
                                                          // Filter the boat reviews based on the boatId
                                                          var filteredBoatReviews = e
                                                              .boatReviews
                                                              .where((boat) =>
                                                                  boat.boatId ==
                                                                  element
                                                                      .boatId)
                                                              .toList();
                                                          // Extract the reviews and make sure they are of the correct type (ReviewssModel)
                                                          List<ReviewssModel>
                                                              reviewValue =
                                                              filteredBoatReviews
                                                                  .expand((element) =>
                                                                      element
                                                                          .reviews)
                                                                  .toList();
                                                          return Container(
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            //  height: 152,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: AppConfig
                                                                  .backGroundColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                        'Your review',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w300,
                                                                            color: AppConfig.fontColor2),
                                                                      ),
                                                                      Spacer(),
                                                                      SvgPicture
                                                                          .asset(
                                                                              'assets/Vector.svg')
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  ReadMoreText(
                                                                    '${reviewValue.first.reviewDescription}',
                                                                    trimLines:
                                                                        3,
                                                                    trimMode:
                                                                        TrimMode
                                                                            .Line,
                                                                    trimCollapsedText:
                                                                        'ReadMore',
                                                                    trimExpandedText:
                                                                        'Readless',
                                                                    moreStyle: TextStyle(
                                                                        color: Colors
                                                                            .blue),
                                                                    lessStyle: TextStyle(
                                                                        color: Colors
                                                                            .blue),
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w300,
                                                                        color: AppConfig
                                                                            .fontColor),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      // ...List.generate(
                                                                      //     reviewValue
                                                                      //         .first.rating,
                                                                      //     (index) =>
                                                                      //         SvgPicture.asset('assets/Star.svg')),
                                                                      ...List
                                                                          .generate(
                                                                        reviewValue
                                                                            .first
                                                                            .rating
                                                                            .floor(), // Full stars based on the integer part of the rating
                                                                        (index) =>
                                                                            Icon(
                                                                          size:
                                                                              20,
                                                                          Icons
                                                                              .star,
                                                                          color:
                                                                              Colors.red,
                                                                        ),
                                                                      ),
                                                                      // Half star if there's a decimal part (e.g., 2.5)
                                                                      if (reviewValue.first.rating -
                                                                              reviewValue.first.rating.floor() >=
                                                                          0.5)
                                                                        Icon(
                                                                          size:
                                                                              20,
                                                                          Icons
                                                                              .star_half,
                                                                          color:
                                                                              Colors.red,
                                                                        ),
                                                                      // Empty stars for the remaining
                                                                      ...List
                                                                          .generate(
                                                                        5 - reviewValue.first.rating.ceil(), // Remaining empty stars
                                                                        (index) =>
                                                                            Icon(
                                                                          size:
                                                                              20,
                                                                          Icons
                                                                              .star_border,
                                                                          color:
                                                                              Colors.red,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                          // Text(reviewValue
                                                          //     .first
                                                          //     .reviewDescription);
                                                        }, error: (Object error,
                                                                StackTrace
                                                                    stackTrace) {
                                                          return SizedBox();
                                                        }, loading: () {
                                                          return CircularProgressIndicator();
                                                        });
                                                      },
                                                    ),
                                              //  Container(
                                              //     width: MediaQuery.of(
                                              //             context)
                                              //         .size
                                              //         .width,
                                              //     height: 152,
                                              //     decoration:
                                              //         BoxDecoration(
                                              //       color:
                                              //           Color(0XFFF5F6FA),
                                              //       borderRadius:
                                              //           BorderRadius
                                              //               .circular(8),
                                              //     ),
                                              //     child: Column(
                                              //       children: [
                                              //         ReadMoreText(
                                              //           '${widget.boatinfo!.description}',
                                              //           trimLines: 4,
                                              //           trimMode:
                                              //               TrimMode.Line,
                                              //           trimCollapsedText:
                                              //               'Readmore',
                                              //           trimExpandedText:
                                              //               'Readless',
                                              //           moreStyle: TextStyle(
                                              //               color: Colors
                                              //                   .blue),
                                              //           lessStyle: TextStyle(
                                              //               color: Colors
                                              //                   .blue),
                                              //         ),
                                              //       ],
                                              //     ),
                                              //   )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ],
                  );
                },
                error: (context, _) => SizedBox(),
                loading: () => Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        );
      }),
    );
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
            width: MediaQuery.of(context).size.width,
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
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Positioned.fill(
            child: PageView.builder(
                itemCount: widget.imagesPath.length,
                controller: _pageController,
                itemBuilder: (context, index) => ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      child: Image.network(
                        width: MediaQuery.of(context).size.width,
                        height: 180,
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
