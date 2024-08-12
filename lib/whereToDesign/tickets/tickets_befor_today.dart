import 'package:design/whereToDesign/tickets/ticket_material.dart';
import 'package:design/whereToDesign/tickets/tickets_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShowBeforTodayTickets extends ConsumerStatefulWidget {
  const ShowBeforTodayTickets({super.key});

  @override
  ConsumerState<ShowBeforTodayTickets> createState() => _ShowTicketsListState();
}

class _ShowTicketsListState extends ConsumerState<ShowBeforTodayTickets> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tickets = ref.read(ticketProvider);
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder(
              future: tickets.ticketArchieved(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else {
                  return ListView.builder(
                      itemCount: tickets.ticketsArchieved!.length,
                      itemBuilder: (_, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(18.0),
                            child: TicketMaterial(
                              colorBackground: Color.fromARGB(255, 37, 90, 114),
                              height: 150,
                              leftChild: _leftChild(
                                  tickets
                                      .ticketsArchieved![index].guests_number,
                                  tickets.ticketsArchieved![index].pets_number,
                                  tickets.ticketsArchieved![index].date_time,
                                  tickets
                                      .ticketsArchieved![index].boarding_time,
                                  tickets
                                      .ticketsArchieved![index].flight_number,
                                  tickets.ticketsArchieved![index].price),
                              rightChild: _rightChild(
                                tickets.ticketsArchieved![index].flight_number,
                                tickets.ticketsArchieved![index].guests_number,
                              ),
                            ),
                          ),
                        );
                      });
                }
              })
          //  TicketMaterial(
          //   colorBackground: Colors.blue,
          //   height: 150,
          //   leftChild: _leftChild(),
          //   rightChild: _rightChild(),
          // ),
          ),
    );
  }
}

Widget _leftChild(int guestsNumber, int petNumber, DateTime date,
    DateTime boarding, String flightNumber, int price) {
  return Container(
      child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        Row(
          children: [
            Text('flight'),
            Spacer(),
            Text(flightNumber),
          ],
        ),
        Row(
          children: [
            Text('Guests'),
            Spacer(),
            Text('${guestsNumber}'),
          ],
        ),
        Row(
          children: [
            Text('Pets'),
            Spacer(),
            Text('${petNumber}'),
          ],
        ),
        Row(
          children: [
            Text('Price'),
            Spacer(),
            Text('${price}'),
          ],
        ),
        Row(
          children: [
            Text('Date'),
            Spacer(),
            Text(
                '${date.day < 10 ? '0${date.day}' : date.day}.${date.month < 10 ? '0${date.month}' : date.month}.${date.year}'),
          ],
        ),
        Row(
          children: [
            Text('Time'),
            Spacer(),
            Text(
                '${boarding.hour < 10 ? '0${boarding.hour}' : boarding.hour}:${boarding.minute < 10 ? '0${boarding.minute}' : boarding.minute}'),
          ],
        )
      ],
    ),
  )
      // Center(
      //   child: Text('${guestsNumber}'),
      // ),
      );
}

Widget _rightChild(String flightNumber, int guestsNumber) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('Flight'),
          Text(flightNumber),
          Spacer(),
          Text('Guests'),
          Text('${guestsNumber}'),
        ],
      ),
    ),
  );
}
