import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:readmore/readmore.dart';

import 'list_image_view.dart';
import 'models/all_reviews_model.dart';

class ShowAllReviews extends ConsumerStatefulWidget {
  final List<ReviewssModel>? reviewsList;
  const ShowAllReviews({super.key, this.reviewsList});
  @override
  ConsumerState<ShowAllReviews> createState() => _ShowAllReviewsState();
}

class _ShowAllReviewsState extends ConsumerState<ShowAllReviews> {
  int? selectedValue;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future showPopUpMenu(Offset globalPosition, BuildContext context) async {
    double top = globalPosition.dy;
    double left = globalPosition.dx;

    await showMenu(
      shadowColor: Colors.black,
      color: Colors.grey.shade600,
      context: context,
      position: RelativeRect.fromLTRB(left, top + 20.0, 20.0, 1),
      items: [
        PopupMenuItem(
          value: 1,
          child: Row(
            children: [
              Text('Usful'),
              Spacer(),
              Icon(selectedValue == 1
                  ? Icons.radio_button_checked_rounded
                  : Icons.circle_outlined),
              SizedBox(
                width: 2,
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: Row(
            children: [
              Text('New'),
              Spacer(),
              Icon(selectedValue == 2
                  ? Icons.radio_button_checked_rounded
                  : Icons.circle_outlined),
            ],
          ),
        ),
        PopupMenuItem(
          value: 3,
          child: Row(
            children: [
              Text('With high rating'),
              Spacer(),
              Icon(selectedValue == 3
                  ? Icons.radio_button_checked_rounded
                  : Icons.circle_outlined),
            ],
          ),
        ),
        PopupMenuItem(
          value: 4,
          child: Row(
            children: [
              Text('With low rating'),
              Spacer(),
              Icon(selectedValue == 4
                  ? Icons.radio_button_checked_rounded
                  : Icons.circle_outlined),
            ],
          ),
        )
      ],
    ).then((value) {
      if (value == 1) {
        widget.reviewsList!.sort(
          // here we are sorting useful element according to how many likes
          (a, b) {
            return b.likes.length.compareTo(a.likes.length);
          },
        );
        selectedValue = 1;
        setState(() {});
      }
      if (value == 2) {
        widget.reviewsList!.sort(
          (a, b) {
            return b.date.compareTo(a.date);
          },
        );
        selectedValue = 2;
        setState(() {});
      }
      if (value == 3) {
        widget.reviewsList!.sort(
          (a, b) {
            return b.rating.compareTo(a.rating);
          },
        );
        selectedValue = 3;
        setState(() {});
      }
      if (value == 4) {
        widget.reviewsList!.sort(
          (a, b) {
            return a.rating.compareTo(b.rating);
          },
        );
        selectedValue = 4;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Reviews'),
        ),
        body: SingleChildScrollView(
          child: (widget.reviewsList!.isEmpty == true ||
                  widget.reviewsList == null)
              ? Center(
                  child: Text('There are no reviews'),
                )
              : Column(
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Total Reviews  ${widget.reviewsList!.length}',
                                  style: TextStyle(fontSize: 20),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTapDown: (details) {
                                    showPopUpMenu(
                                        details.globalPosition, context);
                                  },
                                  child: Icon(Icons.swap_vert_outlined),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      color: Colors.grey.shade700,
                    ),
                    ...widget.reviewsList!.map(
                      (element) => Card(
                        color: Colors.grey.shade800,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(999),
                                      child: Image.network(
                                        element.userPhoto,
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('${element.userName}'),
                                    Spacer(),
                                    Text(
                                      '${element.date}',
                                      style: TextStyle(fontSize: 13),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    ...List.generate(
                                      element.rating,
                                      (index) => Icon(
                                        size: 15,
                                        Icons.star,
                                        color: Colors.yellow,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Description',
                                  style: TextStyle(fontSize: 20),
                                ),
                                ReadMoreText(
                                  '${element.reviewDescription}',
                                  trimLines: 4,
                                  trimMode: TrimMode.Line,
                                  trimCollapsedText: 'Readmore',
                                  trimExpandedText: 'Readless',
                                  moreStyle: TextStyle(color: Colors.blue),
                                  lessStyle: TextStyle(color: Colors.blue),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 100,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: element.photos.length,
                                      itemBuilder: (context, reviewIndex) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return ImageListView(
                                                imageListed: element.photos,
                                              );
                                            }));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                fit: BoxFit.cover,
                                                height: 90,
                                                width: 90,
                                                element.photos[reviewIndex],
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                                SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  child: Row(
                                    children: [
                                      Text((element.likes.isEmpty ||
                                              element.likes == null)
                                          ? '0'
                                          : '${element.likes.length}'),
                                      SizedBox(width: 10),
                                      Icon(Icons.thumb_up_alt_sharp),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Text((element.dislikes.isEmpty ||
                                              element.dislikes == null)
                                          ? '0'
                                          : '${element.dislikes.length}'),
                                      SizedBox(width: 10),
                                      Icon(Icons.thumb_down_alt_sharp),
                                    ],
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    )
                    // holdReview.when(
                    //   data: (data) {
                    //     // // Calculate the sum of all ratings
                    //     // final totalRating = data.boatReviews
                    //     //     .map((e) => e.rating)
                    //     //     .fold(0, (prev, rating) => prev + rating);
                    //     // //.reduce((prev, rating) => prev + rating);
                    //     // // or we can use fold or reduce

                    //     // // how to get the average of totalRating
                    //     // final averageRating = data.reviews.isNotEmpty
                    //     //     ? totalRating / data.reviews.length
                    //     //     : 0;
                    //     return Column(
                    //       children: [
                    //         Card(
                    //           child: Padding(
                    //             padding: const EdgeInsets.all(8.0),
                    //             child: Column(
                    //               children: [
                    //                 Row(
                    //                   children: [
                    //                     Text(
                    //                       'Total Reviews  ${data.boatReviews.length}',
                    //                       style: TextStyle(fontSize: 20),
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 // Row(
                    //                 //   children: [
                    //                 //     ...List.generate(
                    //                 //         averageRating.toInt(),
                    //                 //         (index) => Icon(
                    //                 //               Icons.star,
                    //                 //               color: Colors.yellow,
                    //                 //             )),
                    //                 //     Text(
                    //                 //         '............................ ${averageRating.toString()} / 5')
                    //                 //   ],
                    //                 // ),
                    //                 SizedBox(
                    //                   height: 20,
                    //                 ),
                    //               ],
                    //             ),
                    //           ),
                    //           color: Colors.grey.shade700,
                    //         ),
                    //         ...data.boatReviews.map((e) => Card(
                    //               color: Colors.grey.shade800,
                    //               child: Padding(
                    //                 padding: const EdgeInsets.all(8.0),
                    //                 child: Column(
                    //                   crossAxisAlignment: CrossAxisAlignment.start,
                    //                   children: [
                    //                     Row(
                    //                       children: [
                    //                         ...e.reviews.map((el) => ClipRRect(
                    //                               borderRadius:
                    //                                   BorderRadius.circular(999),
                    //                               child: Image.network(
                    //                                 el.userPhoto,
                    //                                 width: 60,
                    //                                 height: 60,
                    //                                 fit: BoxFit.cover,
                    //                               ),
                    //                             )),
                    //                         SizedBox(
                    //                           width: 20,
                    //                         ),
                    //                         Text(
                    //                             '${e.reviews.map((el) => el.userName).toString()}'),
                    //                       ],
                    //                     ),
                    //                     SizedBox(
                    //                       height: 10,
                    //                     ),
                    //                     Text(
                    //                       'Description',
                    //                       style: TextStyle(fontSize: 20),
                    //                     ),
                    //                     ReadMoreText(
                    //                       '${e.reviews.map((el) => el.reviewDescription).toString()}',
                    //                       trimLines: 4,
                    //                       trimMode: TrimMode.Line,
                    //                       trimCollapsedText: 'Readmore',
                    //                       trimExpandedText: 'Readless',
                    //                       moreStyle: TextStyle(color: Colors.blue),
                    //                       lessStyle: TextStyle(color: Colors.blue),
                    //                     ),
                    //                     // Text(e.reviewDescription),
                    //                     SizedBox(
                    //                       height: 10,
                    //                     ),
                    //                     // Row(
                    //                     //   children: [

                    //                     //     ...List.generate(
                    //                     //       e.reviews.map((el) => el.rating),
                    //                     //       (index) => Icon(
                    //                     //         Icons.star,
                    //                     //         color: Colors.yellow,
                    //                     //       ),
                    //                     //     ),
                    //                     //     SizedBox(
                    //                     //       width: 10,
                    //                     //     ),
                    //                     //     Text(e.reviews.map((el) => el.userPhoto).toString())
                    //                     //   ],
                    //                     // ),
                    //                   ],
                    //                 ),
                    //               ),
                    //             )),
                    //       ],
                    //     );
                    //   },
                    //   error: (context, _) => Text('error'),
                    //   loading: () => CircularProgressIndicator(),
                    // ),
                  ],
                ),
        ));
  }
}
