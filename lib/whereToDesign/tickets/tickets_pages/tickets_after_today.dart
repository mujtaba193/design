import 'package:design/whereToDesign/tickets/tickets_provider_folder/tickets_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../ticket_custom.dart';

class ShowAfterTodayTickets extends ConsumerStatefulWidget {
  const ShowAfterTodayTickets({super.key});

  @override
  ConsumerState<ShowAfterTodayTickets> createState() => _ShowTicketsListState();
}

class _ShowTicketsListState extends ConsumerState<ShowAfterTodayTickets> {
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
              future: tickets.ticketAfterToday(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (tickets.ticketsAfter!.isEmpty) {
                  return Center(
                    child: Text(
                      'No ticket found',
                      style: TextStyle(color: Colors.white60, fontSize: 20),
                    ),
                  );
                } else {
                  return CustomTicketList(
                    ticketList: tickets.ticketsAfter!,
                  );
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
