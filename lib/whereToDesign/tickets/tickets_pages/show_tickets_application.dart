import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/all_reviews_model.dart';
import '../../providers/all_reviews_provider.dart';
import '../../show_all_reviews.dart';
import '../tickets_provider_folder/tickets_application_provider.dart';
import '../timer/timer.dart';

class ShowTicketsApplication extends ConsumerStatefulWidget {
  ShowTicketsApplication({super.key});

  @override
  ConsumerState<ShowTicketsApplication> createState() =>
      _ShowTicketsApplicationState();
}

class _ShowTicketsApplicationState
    extends ConsumerState<ShowTicketsApplication> {
  int time = DateTime.now().minute;
  ValueNotifier<int> counter = ValueNotifier<int>(0);
  bool likeValue = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ticketsHolder = ref.read(ticketApplicationProvider);
    final reviewHolder = ref.watch(allReviewsProvider);
    return Scaffold(
      body: FutureBuilder(
        future: ticketsHolder.readJsonDataApp(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // Handle the error state
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData ||
              ticketsHolder.ticketList == null ||
              ticketsHolder.ticketList!.isEmpty) {
            // Handle the empty data state
            return Center(
              child: Text('No tickets found.'),
            );
          } else {
            return ListView.builder(
              shrinkWrap: true,
              // physics: NeverScrollableScrollPhysics(),
              itemCount: ticketsHolder.ticketList!.length,
              itemBuilder: (_, index) => GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Card(
                    elevation: 5,
                    shadowColor: Colors.grey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            CardItemView(
                                items: ticketsHolder.ticketList![index].photos),
                            Positioned(
                              right: 10,
                              top: 10,
                              child: IconButton(
                                  onPressed: () {},
                                  // the Icon of favorite button.
                                  icon: SvgPicture.asset('assets/Heart 2.svg')),
                            ),
                            Positioned(
                                left: 10,
                                top: 10,
                                child: Container(
                                  // width: 180,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: ticketsHolder
                                                .ticketList![index].status ==
                                            'Confirmed'
                                        ? Color(0XFF19AE7A)
                                        : Color(0xff2296B7),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: ticketsHolder
                                                  .ticketList![index].status ==
                                              'Confirmed'
                                          ? Text(
                                              'Approved! Prepayment expected')
                                          : Text(
                                              'Waiting a response in 5 mint '),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'ID  ${ticketsHolder.ticketList![index].id}'),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    '${ticketsHolder.ticketList![index].name}',
                                    style: TextStyle(fontSize: 25),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.circle,
                                    color: ticketsHolder
                                                .ticketList![index].status ==
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
                                  SvgPicture.asset('assets/Group 3.svg'),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                      ' Up to ${ticketsHolder.ticketList![index].guests} '),
                                  Text(
                                      '${ticketsHolder.ticketList![index].guests < 2 ? 'guest' : 'guests'}'),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    // like Icon.
                                    icon: SvgPicture.asset('assets/Like.svg'),
                                  ),
                                  Text(
                                      '${ticketsHolder.ticketList![index].rating}'),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      List<ReviewssModel> reviewsList = [];
                                      reviewHolder.whenData((e) {
                                        // Filter the boat reviews based on the boatId
                                        var filteredBoatReviews = e.boatReviews
                                            .where((boat) =>
                                                boat.boatId ==
                                                ticketsHolder
                                                    .ticketList![index].boatId)
                                            .toList();
                                        // Extract the reviews and make sure they are of the correct type (ReviewssModel)
                                        List<ReviewssModel> reviewValue =
                                            filteredBoatReviews
                                                .expand((element) =>
                                                    element.reviews)
                                                .toList();

                                        // Add the reviews to the reviewsList
                                        reviewsList.addAll(reviewValue);
                                      });
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return ShowAllReviews(
                                              reviewsList: reviewsList,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    // Review Icon.
                                    icon: SvgPicture.asset(
                                        'assets/Message 29.svg'),
                                  ),
                                  Consumer(
                                    builder: (BuildContext context, ref, _) {
                                      return reviewHolder.when(data: (e) {
                                        // Filter the boat reviews based on the boatId
                                        var filteredBoatReviews = e.boatReviews
                                            .where((boat) =>
                                                boat.boatId ==
                                                ticketsHolder
                                                    .ticketList![index].boatId)
                                            .toList();
                                        // Extract the reviews and make sure they are of the correct type (ReviewssModel)
                                        List<ReviewssModel> reviewValue =
                                            filteredBoatReviews
                                                .expand((element) =>
                                                    element.reviews)
                                                .toList();
                                        return Text(
                                            reviewValue.length.toString());
                                      }, error: (Object error,
                                          StackTrace stackTrace) {
                                        return SizedBox();
                                      }, loading: () {
                                        return CircularProgressIndicator();
                                      });
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(),
                              Row(
                                children: [
                                  // location Icon.
                                  SvgPicture.asset('assets/Ellipse 83.svg'),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                      '${ticketsHolder.ticketList![index].startAddress.name}'),
                                  Spacer(),
                                  if (ticketsHolder.ticketList![index]
                                          .startAddress.name ==
                                      ticketsHolder
                                          .ticketList![index].destination.name)
                                    Icon(
                                      Icons.refresh,
                                      color: const Color(0xff2296B7),
                                    )
                                ],
                              ),
                              ticketsHolder.ticketList![index].startAddress
                                          .name ==
                                      ticketsHolder
                                          .ticketList![index].destination.name
                                  ? SizedBox()
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SvgPicture.asset('assets/Frame 31.svg'),
                                        Row(
                                          children: [
                                            //destination Icon.
                                            SvgPicture.asset(
                                                'assets/Ellipse 83.svg'),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Text(
                                                '${ticketsHolder.ticketList![index].destination.name}')
                                          ],
                                        ),
                                      ],
                                    ),
                              Divider(),
                              SizedBox(
                                height: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      //Clock Icon.
                                      SvgPicture.asset(
                                          'assets/Clock Circle.svg'),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        '${ticketsHolder.ticketList![index].startTime.day < 10 ? '0${ticketsHolder.ticketList![index].startTime.day}' : ticketsHolder.ticketList![index].startTime.day}.${ticketsHolder.ticketList![index].startTime.month < 10 ? '0${ticketsHolder.ticketList![index].startTime.month}' : ticketsHolder.ticketList![index].startTime.month} ${ticketsHolder.ticketList![index].startTime.hour < 10 ? '0 ${ticketsHolder.ticketList![index].startTime.hour}' : ticketsHolder.ticketList![index].startTime.hour}:${ticketsHolder.ticketList![index].startTime.minute < 10 ? '0${ticketsHolder.ticketList![index].startTime.minute}' : ticketsHolder.ticketList![index].startTime.minute} - ${ticketsHolder.ticketList![index].endTime.day < 10 ? '0${ticketsHolder.ticketList![index].endTime.day}' : ticketsHolder.ticketList![index].endTime.day}.${ticketsHolder.ticketList![index].endTime.month < 10 ? '0${ticketsHolder.ticketList![index].endTime.month}' : ticketsHolder.ticketList![index].endTime.month} ${ticketsHolder.ticketList![index].endTime.hour < 10 ? '0 ${ticketsHolder.ticketList![index].endTime.hour}' : ticketsHolder.ticketList![index].endTime.hour}:${ticketsHolder.ticketList![index].endTime.minute < 10 ? '0${ticketsHolder.ticketList![index].endTime.minute}' : ticketsHolder.ticketList![index].endTime.minute}',
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '${ticketsHolder.ticketList![index].price} R',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: const Color(0xff19AE7A),
                                        ),
                                      ),
                                      Text(' /  2 hour'),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: GestureDetector(
                                      // onTap: () {
                                      //   if (counter.value < 1) {
                                      //     timetFunction();
                                      //   }
                                      // },
                                      onTapCancel: () {},
                                      child: Container(
                                        height: 46,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            color: ticketsHolder
                                                        .ticketList![index]
                                                        .status ==
                                                    'Confirmed'
                                                ? Color(0XFF19AE7A)
                                                : Colors.grey),
                                        child: Center(
                                          child: ticketsHolder
                                                      .ticketList![index]
                                                      .status ==
                                                  'Confirmed'
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text('Booking '),
                                                    Text('('),
                                                    TimerCountdown(
                                                      spacerWidth: 5,
                                                      endTime: DateTime.now()
                                                          .add(Duration(
                                                              minutes: 15)),
                                                      format:
                                                          CountDownTimerFormat
                                                              .minutesSeconds,
                                                    ),
                                                    Text(')')
                                                  ],
                                                )
                                              : Text('Waiting confirmation'),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
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
