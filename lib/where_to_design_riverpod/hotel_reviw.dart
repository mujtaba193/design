import 'dart:convert';

import 'package:design/whereToDesign/users_model/boat_model.dart';
import 'package:flutter/material.dart';

class HotelReview extends StatefulWidget {
  const HotelReview({Key? key});

  @override
  State<HotelReview> createState() => _HotelReviewState();
}

class _HotelReviewState extends State<HotelReview> {
  final List<String> images = [
    'lib/image/h1.jpg',
    'lib/image/h2.jpg',
    'lib/image/h3.jpeg'
  ];
  List<Widget>? imagePage;
  int selectedImage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  List<BoatModel>? boatList;

  @override
  void initState() {
    super.initState();
    imagePage = List.generate(
      images.length,
      (index) => ImagesHolder(
        imagePath: images[index],
      ),
    );
    readJsondata();
  }

  readJsondata() async {
    //   File file = await File('assets/images/boat.json');
    var jsonStr = await DefaultAssetBundle.of(context)
        .loadString('asset/images_list.json');
    //   String contents = await file.readAsString();

    // Parse the JSON data
    //  List<dynamic> jsonData = jsonDecode(contents);
    List<dynamic> jsonData = jsonDecode(jsonStr);

    // Convert JSON data to List<BoatModel>
    boatList = jsonData.map((json) => BoatModel.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder(
            future: readJsondata(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else {
                return ListView.builder(
                  itemCount:
                      boatList!.length, // Just one item, the hotel review
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.height / 48),
                      margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.height / 48,
                        top: MediaQuery.of(context).size.height / 10,
                        right: MediaQuery.of(context).size.height / 48,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      width: MediaQuery.of(context).size.width / 1.1,
                      height: MediaQuery.of(context).size.height / 2.5,
                      child: Stack(
                        children: [
                          PageView.builder(
                            onPageChanged: (value) {
                              setState(() {
                                selectedImage = value;
                              });
                            },
                            controller: _pageController,
                            itemCount: images.length,
                            itemBuilder: (context, index) {
                              return imagePage![index];
                            },
                          ),
                          Positioned(
                            bottom: MediaQuery.of(context).size.height / 90,
                            left: MediaQuery.of(context).size.width / 3,
                            child: Row(
                              children: List<Widget>.generate(
                                imagePage!.length,
                                (index) => Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: InkWell(
                                    onTap: () {
                                      _pageController.animateToPage(
                                        index,
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.ease,
                                      );
                                    },
                                    child: CircleAvatar(
                                      radius: 4,
                                      backgroundColor: selectedImage == index
                                          ? Colors.white
                                          : Colors.white54,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            }),
      ),
    );
  }
}

class ImagesHolder extends StatelessWidget {
  final String? imagePath;
  const ImagesHolder({Key? key, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath!,
      fit: BoxFit.cover,
    );
  }
}
