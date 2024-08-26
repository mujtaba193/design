import 'package:design/whereToDesign/tickets/tickets_pages/ticket_material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'tickets_models/tickets_model.dart';

class CustomTicketList extends ConsumerStatefulWidget {
  List<TicketModel> ticketList;
  Color? ticketColor;
  CustomTicketList({super.key, required this.ticketList, this.ticketColor});

  @override
  ConsumerState<CustomTicketList> createState() => _ShowTicketsListState();
}

class _ShowTicketsListState extends ConsumerState<CustomTicketList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: widget.ticketList.length,
        itemBuilder: (_, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18.0),
              child: TicketMaterial(
                colorBackground:
                    widget.ticketColor ?? Color.fromARGB(255, 37, 90, 114),
                height: 150,
                leftChild: TicketCustom.leftChild(
                    widget.ticketList[index].guests_number,
                    widget.ticketList[index].pets_number,
                    widget.ticketList[index].date_time,
                    widget.ticketList[index].boarding_time,
                    widget.ticketList[index].flight_number,
                    widget.ticketList[index].price),
                rightChild: TicketCustom.rightChild(
                  widget.ticketList[index].flight_number,
                  widget.ticketList[index].guests_number,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  //  TicketMaterial(
  //   colorBackground: Colors.blue,
  //   height: 150,
  //   leftChild: _leftChild(),
  //   rightChild: _rightChild(),
  // ),
}
///////////////////////////////////////////////////////////////////////

class TicketCustom {
  TicketCustom();
  static Widget leftChild(int guestsNumber, int petNumber, DateTime date,
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

  static Widget rightChild(String flightNumber, int guestsNumber) {
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
}
