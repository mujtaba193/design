import 'dart:convert';

import 'package:design/where%20to%20design/show_information.dart';
import 'package:design/where%20to%20design/users_model/boat_model.dart';
import 'package:design/where%20to%20design/where_to.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class Review2 extends StatefulWidget {
  List<BoatModel>? newBoatList;
  Review2({super.key, this.newBoatList});

  @override
  State<Review2> createState() => _Review2State();
}

class _Review2State extends State<Review2> {
  List<BoatModel>? boatList;

  @override
  void initState() {
    readJsondata();
    super.initState();
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
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
          future: readJsondata(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.010,
                      ),
                      width: MediaQuery.of(context).size.width * 0.95,
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
                      child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) {
                                return WhereTo(boatList: boatList);
                              }),
                            );
                          },
                          child: Text('Search')),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: widget.newBoatList == null
                          ? boatList!.length
                          : widget.newBoatList!
                              .length, // here it was boatList!.length
                      itemBuilder: (_, index) => GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                if (widget.newBoatList == null) {
                                  return ShowInformation(
                                      boatList: boatList![index]);
                                } else {
                                  return ShowInformation(
                                      boatList: widget.newBoatList![index]);
                                }
                                /* return ShowInformation(
                                    boatList: widget.newBoatList![
                                        index]); */ // here it was boatList![index]
                              },
                            ),
                          );
                        },
                        child: CardItemView(
                          items: widget.newBoatList == null
                              ? boatList![index].imageList
                              : widget.newBoatList![index].imageList,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
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
