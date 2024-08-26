import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

import '../tickets_provider_folder/tickets_application_provider.dart';

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

  @override
  void initState() {
    super.initState();
  }

  timetFunction() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      counter.value = timer.tick;
      counter.value = counter.value;
      //  time--;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ticketsHolder = ref.read(ticketApplicationProvider);
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              ticketsHolder.ticketList![index].status ==
                                      'Confirmed'
                                  ? Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                    )
                                  : Icon(
                                      Icons.hourglass_bottom,
                                    ),
                              Text(
                                  '${ticketsHolder.ticketList![index].status}'),
                              Spacer(),
                              GestureDetector(
                                child: Row(
                                  children: [
                                    Text('Edit  '),
                                    Icon(Icons.mode_edit_outline_outlined)
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Stack(
                            children: [
                              CardItemView(
                                  items:
                                      ticketsHolder.ticketList![index].photos),
                              Positioned(
                                right: 10,
                                top: 10,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text('${ticketsHolder.ticketList![index].name}'),
                          Row(
                            children: [
                              Icon(Icons.people),
                              Text(
                                  '${ticketsHolder.ticketList![index].guests}'),
                              Text(
                                  '${ticketsHolder.ticketList![index].guests < 2 ? 'guest' : 'guests'}'),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.location_on_outlined),
                              Text(
                                  '${ticketsHolder.ticketList![index].startAddress.name}'),
                              if (ticketsHolder
                                      .ticketList![index].startAddress.name ==
                                  ticketsHolder
                                      .ticketList![index].destination.name)
                                Icon(Icons.autorenew_rounded)
                            ],
                          ),
                          ticketsHolder.ticketList![index].startAddress.name ==
                                  ticketsHolder
                                      .ticketList![index].destination.name
                              ? SizedBox()
                              : Column(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(width: 40),
                                        Icon(Icons.arrow_downward),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.location_on_outlined),
                                        Text(
                                            '${ticketsHolder.ticketList![index].destination.name}')
                                      ],
                                    ),
                                  ],
                                ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                          '${ticketsHolder.ticketList![index].price}'),
                                      Text(' Ruble/2 hour'),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '${ticketsHolder.ticketList![index].startTime.day < 10 ? '0${ticketsHolder.ticketList![index].startTime.day}' : ticketsHolder.ticketList![index].startTime.day}.${ticketsHolder.ticketList![index].startTime.month < 10 ? '0${ticketsHolder.ticketList![index].startTime.month}' : ticketsHolder.ticketList![index].startTime.month} ${ticketsHolder.ticketList![index].startTime.hour < 10 ? '0 ${ticketsHolder.ticketList![index].startTime.hour}' : ticketsHolder.ticketList![index].startTime.hour}:${ticketsHolder.ticketList![index].startTime.minute < 10 ? '0${ticketsHolder.ticketList![index].startTime.minute}' : ticketsHolder.ticketList![index].startTime.minute} - ${ticketsHolder.ticketList![index].endTime.day < 10 ? '0${ticketsHolder.ticketList![index].endTime.day}' : ticketsHolder.ticketList![index].endTime.day}.${ticketsHolder.ticketList![index].endTime.month < 10 ? '0${ticketsHolder.ticketList![index].endTime.month}' : ticketsHolder.ticketList![index].endTime.month} ${ticketsHolder.ticketList![index].endTime.hour < 10 ? '0 ${ticketsHolder.ticketList![index].endTime.hour}' : ticketsHolder.ticketList![index].endTime.hour}:${ticketsHolder.ticketList![index].endTime.minute < 10 ? '0${ticketsHolder.ticketList![index].endTime.minute}' : ticketsHolder.ticketList![index].endTime.minute}',
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                          'Id  ${ticketsHolder.ticketList![index].id}')
                                    ],
                                  ),
                                ],
                              ),
                              Spacer(),
                              Column(
                                children: [
                                  ticketsHolder.ticketList![index].status ==
                                          'Confirmed'
                                      ? ValueListenableBuilder(
                                          valueListenable: counter,
                                          builder: (BuildContext context, value,
                                              Widget? child) {
                                            return Text(
                                              value.toString(),
                                            );
                                          },
                                          child: Text('${counter.value}'),
                                        )
                                      : SizedBox(),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      ticketsHolder.ticketList![index].status ==
                                              'Confirmed'
                                          ? GestureDetector(
                                              onTap: () {
                                                if (counter.value < 1) {
                                                  timetFunction();
                                                }
                                              },
                                              onTapCancel: () {},
                                              child: Container(
                                                height: 30,
                                                width: 80,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                    color: Colors.green),
                                                child: Center(
                                                  child: Text('payment'),
                                                ),
                                              ),
                                            )
                                          : GestureDetector(
                                              child: Container(
                                                height: 30,
                                                width: 80,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                    color: Colors.red),
                                                child: Center(
                                                  child: Text('wait'),
                                                ),
                                              ),
                                            ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
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
