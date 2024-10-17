import 'package:design/whereToDesign/providers/reviews_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:readmore/readmore.dart';

class ShowReview extends ConsumerWidget {
  const ShowReview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final holdReview = ref.watch(reviewProvider);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Reviews'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // ...holdReview.when(
              //   data: (data) => data.reviews.map(
              //     (e) => Card(
              //       color: Colors.grey.shade800,
              //       child: Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Row(
              //               children: [
              //                 ClipRRect(
              //                   borderRadius: BorderRadius.circular(999),
              //                   child: Image.network(
              //                     e.userPhoto,
              //                     width: 60,
              //                     height: 60,
              //                     fit: BoxFit.cover,
              //                   ),
              //                 ),
              //                 SizedBox(
              //                   width: 20,
              //                 ),
              //                 Text('${e.userName}'),
              //               ],
              //             ),
              //             SizedBox(
              //               height: 10,
              //             ),
              //             Text(
              //               'Description',
              //               style: TextStyle(fontSize: 20),
              //             ),
              //             Text(e.reviewDescription),
              //             SizedBox(
              //               height: 10,
              //             ),
              //             Row(
              //               children: [
              //                 ...List.generate(
              //                     e.rating, (e) => Icon(Icons.star)),
              //                 SizedBox(
              //                   width: 10,
              //                 ),
              //                 Text(e.date)
              //               ],
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              //   error: (context, _) => [Text('error')],
              //   loading: () => [
              //     CircularProgressIndicator(),
              //   ],
              // ),
              holdReview.when(
                data: (data) {
                  // Calculate the sum of all ratings
                  final totalRating = data.reviews
                      .map((e) => e.rating)
                      .fold(0, (prev, rating) => prev + rating);

// how to get the average of totalRating

                  final averageRating = data.reviews.isNotEmpty
                      ? totalRating / data.reviews.length
                      : 0;
                  return Column(
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Total Reviews  $totalRating',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  ...List.generate(
                                      averageRating.toInt(),
                                      (index) => Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                          )),
                                  Text(
                                      '............................ ${averageRating.toString()} / 5')
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
                      ...data.reviews.map(
                        (e) => Card(
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
                                        e.userPhoto,
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text('${e.userName}'),
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
                                  '${e.reviewDescription}',
                                  trimLines: 4,
                                  trimMode: TrimMode.Line,
                                  trimCollapsedText: 'Readmore',
                                  trimExpandedText: 'Readless',
                                  moreStyle: TextStyle(color: Colors.blue),
                                  lessStyle: TextStyle(color: Colors.blue),
                                ),
                                // Text(e.reviewDescription),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    ...List.generate(
                                        e.rating,
                                        (index) => Icon(
                                              Icons.star,
                                              color: Colors.yellow,
                                            )),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(e.date)
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
                error: (context, _) => Text('error'),
                loading: () => CircularProgressIndicator(),
              ),
            ],
          ),
        ));
  }
}
