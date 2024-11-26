import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../tickets_provider_folder/tickets_application_future_provider.dart';
import 'tickets_review_page.dart';

class TicketBeforeTodayNew extends ConsumerStatefulWidget {
  const TicketBeforeTodayNew({super.key});

  @override
  ConsumerState<TicketBeforeTodayNew> createState() =>
      _TicketBeforTodayNewState();
}

class _TicketBeforTodayNewState extends ConsumerState<TicketBeforeTodayNew> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theHolder = ref.watch(ticketApplicationFutureProvider);

    return Scaffold(
      appBar: AppBar(),
      body: Consumer(builder: (context, ref, _) {
        return SingleChildScrollView(
          child: Column(
            children: [
              theHolder.when(
                data: (list) {
                  return Column(
                    children: [
                      ...list
                          .map(
                            (element) => Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Card(
                                elevation: 5,
                                shadowColor: Colors.grey,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.network(
                                            element.photos.first,
                                            height: 100,
                                            width: 100,
                                            fit: BoxFit.cover,
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('${element.name}'),
                                              Text(
                                                '${element.startTime.day < 10 ? '0${element.startTime.day}' : element.startTime.day}.${element.startTime.month < 10 ? '0${element.startTime.month}' : element.startTime.month}.${element.startTime.year}   ${element.startTime.hour < 10 ? '0${element.startTime.hour}' : element.startTime.hour}:${element.startTime.minute < 10 ? '0${element.startTime.minute}' : element.startTime.minute}',
                                              ),
                                              Text(
                                                '${element.endTime.day < 10 ? '0${element.endTime.day}' : element.endTime.day}.${element.endTime.month < 10 ? '0${element.endTime.month}' : element.endTime.month}.${element.endTime.year}   ${element.endTime.hour < 10 ? '0${element.endTime.hour}' : element.endTime.hour}:${element.endTime.minute < 10 ? '0${element.endTime.minute}' : element.endTime.minute}',
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      element.rating == null
                                          ? GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      return TicketsReviewPage();
                                                    },
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    width: 2,
                                                    color: Colors.green,
                                                  ),
                                                ),
                                                height: 25,
                                                width: 120,
                                                child: Center(
                                                  child: Text('Leave review'),
                                                ),
                                              ),
                                            )
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ...List.generate(
                                                  element.rating!,
                                                  (index) => Icon(
                                                    size: 15,
                                                    Icons.star,
                                                    color: Colors.yellow,
                                                  ),
                                                ),
                                                SizedBox(width: 5),
                                                Icon(Icons.edit),
                                              ],
                                            ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Spacer(),
                                          Text('${element.id}')
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ],
                  );
                },
                error: (context, _) => SizedBox(),
                loading: () => Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
