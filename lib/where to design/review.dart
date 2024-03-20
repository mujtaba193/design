import 'dart:convert';

import 'package:design/where%20to%20design/users_model/boat_model.dart';
import 'package:flutter/material.dart';

class Review extends StatefulWidget {
  const Review({super.key});

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  final List<String> images = [
    'lib/image/h1.jpg',
    'lib/image/h2.jpg',
    'lib/image/h3.jpeg'
  ];
  List<Widget>? imagePage;
  int selectedImege = 0;
  final PageController _pageController = PageController(initialPage: 0);
  List<BoatModel>? boatList;
  @override
  void initState() {
    // TODO: implement initState
    imagePage = List.generate(
      images.length,
      (index) => ImagesHolder(
        imagePath: images[index],
      ),
    );
    readJsondata();
    super.initState();
  }

  // json function to read data from json
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
                    itemCount: boatList!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.height / 48),
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height / 48,
                            top: MediaQuery.of(context).size.height / 10,
                            right: MediaQuery.of(context).size.height / 48),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  // offset: Offset(4.0, 4.0),
                                  blurRadius: 10,
                                  spreadRadius: 2),
                            ]),
                        width: MediaQuery.of(context).size.width / 1.1,
                        height: 500,
                        child: Row(
                          children: boatList![index]
                              .imageList
                              .asMap()
                              .entries
                              .map((e) => Stack(
                                    children: [
                                      Container(
                                        child: PageView.builder(
                                          onPageChanged: (value) {
                                            setState(() {
                                              selectedImege = value;
                                            });
                                          },
                                          controller: _pageController,
                                          itemCount:
                                              boatList![index].imageList.length,
                                          itemBuilder: (context, index) {
                                            return ImagesHolder(
                                              imagePath: e.value,
                                            );
                                          },
                                        ),
                                      ),
                                      Container(
                                        child: Positioned(
                                          bottom: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              90,
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
                                          child: Row(
                                            children: List<Widget>.generate(
                                              imagePage!.length,
                                              (index) => Padding(
                                                padding:
                                                    const EdgeInsets.all(2),
                                                child: InkWell(
                                                  onTap: () {
                                                    _pageController
                                                        .animateToPage(index,
                                                            duration: Duration(
                                                                milliseconds:
                                                                    300),
                                                            curve: Curves.ease);
                                                  },
                                                  child: CircleAvatar(
                                                    radius: 4,
                                                    backgroundColor:
                                                        selectedImege == index
                                                            ? Colors.white
                                                            : Colors.white54,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ))
                              .toList(),
                        ),
                      );
                    });
              }
            }),
      ),
    );
  }
}

class ImagesHolder extends StatelessWidget {
  final String? imagePath;
  const ImagesHolder({super.key, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath!,
      fit: BoxFit.cover,
    );
  }
}
