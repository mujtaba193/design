import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:design/where%20to%20design/users_model/boat_model.dart';
import 'package:flutter/material.dart';

class Review2 extends StatefulWidget {
  const Review2({super.key});

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
    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder(
            future: readJsondata(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else {
                return ListView.builder(
                  itemCount: boatList!.length,
                  itemBuilder: (_, index) => CardItemView(
                    items: boatList![index].imageList,
                  ),
                );
              }
            }),
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
          ImageSliderView(
            imagesPath: items,
          ),
          const SizedBox(height: 10),
          Container(
            height: 100,
            color: Colors.red,
          )
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
      child: Stack(
        children: [
          Positioned.fill(
            child: PageView.builder(
              controller: _pageController,
              itemBuilder: (context, index) =>
                  CachedNetworkImage(imageUrl: widget.imagesPath.toString()),
            ),
          ),
          Positioned(
            bottom: 8,
            left: 0,
            right: 0,
            child: counterView,
          )
        ],
      ),
    );
  }
}
