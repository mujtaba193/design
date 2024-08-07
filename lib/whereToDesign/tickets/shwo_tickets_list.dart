import 'package:design/whereToDesign/tickets/ticket_material.dart';
import 'package:design/whereToDesign/tickets/tickets_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShowTicketsList extends ConsumerStatefulWidget {
  const ShowTicketsList({super.key});

  @override
  ConsumerState<ShowTicketsList> createState() => _ShowTicketsListState();
}

class _ShowTicketsListState extends ConsumerState<ShowTicketsList> {
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
              future: tickets.readJsondataTickets(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else {
                  return ListView.builder(
                      itemCount: tickets.ticketsList!.length,
                      itemBuilder: (_, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(18.0),
                            child: TicketMaterial(
                              colorBackground: Color.fromARGB(255, 70, 91, 109),
                              height: 150,
                              leftChild: _leftChild(
                                  tickets.ticketsList![index].guests_number,
                                  tickets.ticketsList![index].pets_number,
                                  tickets.ticketsList![index].date_time,
                                  tickets.ticketsList![index].boarding_time,
                                  tickets.ticketsList![index].flight_number,
                                  tickets.ticketsList![index].price),
                              rightChild: _rightChild(),
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
        )
      ],
    ),
  )
      // Center(
      //   child: Text('${guestsNumber}'),
      // ),
      );
}

Widget _rightChild() {
  return Container(
    child: Center(
      child: Text('Ticket number 1'),
    ),
  );
}
