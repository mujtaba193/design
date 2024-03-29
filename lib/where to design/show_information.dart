import 'package:design/where%20to%20design/list_image_view.dart';
import 'package:design/where%20to%20design/review2.dart';
import 'package:design/where%20to%20design/users_model/boat_model.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:readmore/readmore.dart';
import 'package:share_plus/share_plus.dart';

class ShowInformation extends StatefulWidget {
  final BoatModel boatList;
  const ShowInformation({super.key, required this.boatList});

  @override
  State<ShowInformation> createState() => _ShowInformationState();
}

class _ShowInformationState extends State<ShowInformation> {
  @override
  void initState() {
    super.initState();
  }

  void shareInfo() {
    CardItemView hh = CardItemView(
      items: widget.boatList.imageList,
    );

    String massage = 'share the information';
    Share.share(massage);
    // Share.shareUri(widget.boatList.imageList.toString());
    Share;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width / 2,
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
        child: TextButton(onPressed: () {}, child: Text('chose from 4600')),
      ),
      appBar: AppBar(
        elevation: 0,
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite),
          ),
          IconButton(
            onPressed: () {
              shareInfo();
            },
            icon: Icon(Icons.share_sharp),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return ImageListView(
                      imageListed: widget.boatList.imageList,
                    );
                  }));
                },
                child: CardItemView(
                  items: widget.boatList.imageList,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(
                MediaQuery.of(context).size.width * 0.01,
              ),
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
              decoration: const BoxDecoration(
                border: GradientBoxBorder(
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
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.person),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.01,
                      ),
                      Text(
                        'Owner',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      Text(
                        '${widget.boatList.boatName}',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Row(
                    children: [
                      Icon(Icons.price_change),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.01,
                      ),
                      Text(
                        'Price',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      Text(
                        '${widget.boatList.finalPrice} ₽',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Row(
                    children: [
                      Icon(Icons.people_alt),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.01,
                      ),
                      Text(
                        'Guests',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      Text(
                        '${widget.boatList.guests}',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_city),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.01,
                      ),
                      Text(
                        'City',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      Text(
                        '${widget.boatList.city}',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Row(
                    children: [
                      Icon(Icons.sell),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.01,
                      ),
                      Text(
                        'Already booked',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
                      Text(
                        '${widget.boatList.bookedStartTime.year}-${widget.boatList.bookedStartTime.month < 10 ? '0${widget.boatList.bookedStartTime.month}' : widget.boatList.bookedStartTime.month}-${widget.boatList.bookedStartTime.day < 10 ? '0${widget.boatList.bookedStartTime.day}' : widget.boatList.bookedStartTime.day} ( ${widget.boatList.bookedStartTime.hour < 10 ? '0${widget.boatList.bookedStartTime.hour}' : widget.boatList.bookedStartTime.hour}:${widget.boatList.bookedStartTime.minute < 10 ? '0${widget.boatList.bookedStartTime.minute}' : widget.boatList.bookedStartTime.minute} to ${widget.boatList.bookedFinishTime.hour < 10 ? '0${widget.boatList.bookedFinishTime.hour}' : widget.boatList.bookedFinishTime.hour}:${widget.boatList.bookedFinishTime.minute < 10 ? '0${widget.boatList.bookedFinishTime.minute}' : widget.boatList.bookedFinishTime.minute})',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Row(
                    children: [
                      Icon(Icons.description),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.01,
                      ),
                      Text(
                        'Description',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(),
                    ),
                    child: ReadMoreText(
                      '${widget.boatList.description}',
                      trimLines: 4,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'Readmore',
                      trimExpandedText: 'Readless',
                      moreStyle: TextStyle(color: Colors.blue),
                      lessStyle: TextStyle(color: Colors.blue),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons
                              .category), // Icon representing characteristics
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.01,
                          ),
                          Text(
                            'Options', // Title for characteristics
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ), // Space between title and characteristics
                      Wrap(
                        spacing: 8, // Horizontal space between chips
                        runSpacing: 8, // Vertical space between chips
                        children: widget.boatList.options.map((options) {
                          return Container(
                            decoration: const BoxDecoration(
                              border: GradientBoxBorder(
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
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(options),
                            ), // Display characteristic as chip
                          );
                        }).toList(),
                      ),
                      //Text(widget.boatList.characteristics.shipyard)
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Row(
                    children: [
                      Icon(Icons.sailing),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.01,
                      ),
                      Text(
                        'characteristics',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Row(
                    children: [
                      Text('Shipyard'),
                      Spacer(),
                      Text(widget.boatList.characteristics.shipyard),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Model'),
                      Spacer(),
                      Text(widget.boatList.characteristics.model),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Year'),
                      Spacer(),
                      Text('${widget.boatList.characteristics.year}'),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Length'),
                      Spacer(),
                      Text('${widget.boatList.characteristics.length}'),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Width'),
                      Spacer(),
                      Text('${widget.boatList.characteristics.width}'),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Power'),
                      Spacer(),
                      Text(widget.boatList.characteristics.power),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Walking speed'),
                      Spacer(),
                      Text(widget.boatList.characteristics.walking_speed),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Cabins'),
                      Spacer(),
                      Text('${widget.boatList.characteristics.cabins}'),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Sleepingplaces'),
                      Spacer(),
                      Text(
                          '${widget.boatList.characteristics.sleeping_places}'),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
