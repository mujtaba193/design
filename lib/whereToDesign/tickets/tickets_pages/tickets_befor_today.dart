import 'package:design/whereToDesign/tickets/tickets_provider_folder/tickets_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../ticket_custom.dart';

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
          } else if (tickets.ticketsArchieved!.isEmpty) {
            return Center(
              child: Text(
                'No ticket found',
                style: TextStyle(color: Colors.white60, fontSize: 20),
              ),
            );
          } else {
            return CustomTicketList(
              ticketList: tickets.ticketsArchieved!,
            );
          }
        },
      )
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
