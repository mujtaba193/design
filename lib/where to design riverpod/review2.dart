import 'package:design/where%20to%20design%20riverpod/show_information.dart';
import 'package:design/where%20to%20design%20riverpod/user_provider/boat_list_provider.dart';
import 'package:design/where%20to%20design%20riverpod/users_model/boat_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class Review2River extends ConsumerStatefulWidget {
  List<BoatModelRiverPod>? newBoatList;
  DateTime? userTimeNow1;
  DateTime? userTimeNow2;
  Review2River(
      {super.key, this.newBoatList, this.userTimeNow1, this.userTimeNow2});

  @override
  ConsumerState<Review2River> createState() => _Review2State();
}

class _Review2State extends ConsumerState<Review2River> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final imageListProvider = ref.read(boatProvider);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        body: imageListProvider.when(
          data: (data) {
            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: (widget.newBoatList == null ||
                      widget.newBoatList!.isEmpty)
                  ? data!.length
                  : widget.newBoatList!.length, // here it was boatList!.length
              itemBuilder: (_, index) {
                data.map(
                  (e) => GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            if (widget.newBoatList == null ||
                                widget.newBoatList!.isEmpty) {
                              return ShowInformation(
                                boatinfo: e,
                                userTimeNow1: widget.userTimeNow1,
                                userTimeNow2: widget.userTimeNow2,
                              );
                            } else {
                              return ShowInformation(
                                boatinfo: widget.newBoatList![index],
                                userTimeNow1: widget.userTimeNow1,
                                userTimeNow2: widget.userTimeNow2,
                              );
                            }
                            /* return ShowInformation(
                                    boatList: widget.newBoatList![
                                        index]); */ // here it was boatList![index]
                          },
                        ),
                      );
                    },
                    child: CardItemView(
                        items: (widget.newBoatList == null ||
                                widget.newBoatList!.isEmpty)
                            ? e.imageList
                            : widget.newBoatList![index].imageList),
                  ),
                );
              },
            );
          },
          error: (_, __) => SizedBox(),
          loading: () => SizedBox(),
        )
        /* FutureBuilder(
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
                        child: widget.newBoatList == null ||
                                widget.newBoatList!.isEmpty
                            ? TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) {
                                      return WhereTo(boatList: boatList);
                                    }),
                                  );
                                },
                                child: Text('Search'))
                            : Row(
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) {
                                            return WhereTo(boatList: boatList);
                                          }),
                                        );
                                      },
                                      child: Text('Search')),
                                  Spacer(),
                                  TextButton(
                                      onPressed: () {
                                        setState(() {
                                          widget.newBoatList = null;
                                          widget.newBoatList = [];
                                        });
                                      },
                                      child: Text('Rreset')),
                                ],
                              ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: (widget.newBoatList == null ||
                                widget.newBoatList!.isEmpty)
                            ? boatList!.length
                            : widget.newBoatList!
                                .length, // here it was boatList!.length
                        itemBuilder: (_, index) => GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  if (widget.newBoatList == null ||
                                      widget.newBoatList!.isEmpty) {
                                    return ShowInformation(
                                      boatinfo: boatList![index],
                                      userTimeNow1: widget.userTimeNow1,
                                      userTimeNow2: widget.userTimeNow2,
                                    );
                                  } else {
                                    return ShowInformation(
                                      boatinfo: widget.newBoatList![index],
                                      userTimeNow1: widget.userTimeNow1,
                                      userTimeNow2: widget.userTimeNow2,
                                    );
                                  }
                                  /* return ShowInformation(
                                    boatList: widget.newBoatList![
                                        index]); */ // here it was boatList![index]
                                },
                              ),
                            );
                          },
                          child: CardItemView(
                              items: (widget.newBoatList == null ||
                                      widget.newBoatList!.isEmpty)
                                  ? boatList![index].imageList
                                  : widget.newBoatList![index].imageList),
                        ),
                      ),*/

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
