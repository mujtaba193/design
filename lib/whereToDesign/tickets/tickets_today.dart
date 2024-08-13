import 'package:design/whereToDesign/tickets/tickets_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'ticket_custom.dart';

class TicketsToday extends ConsumerStatefulWidget {
  const TicketsToday({super.key});

  @override
  ConsumerState<TicketsToday> createState() => _ShowTicketsListState();
}

class _ShowTicketsListState extends ConsumerState<TicketsToday> {
  @override
  void initState() {
    // TODO: implement initState
    callJasonFunction();
    super.initState();
  }

  callJasonFunction() async {
    await ref.read(ticketProvider).readJsondataTickets();
  }

  @override
  Widget build(BuildContext context) {
    final tickets = ref.read(ticketProvider);
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder(
              future: tickets.functionTicketToday(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (tickets.ticketsToday!.isEmpty) {
                  return Center(
                    child: Text(
                      'There is no ticket for today',
                      style: TextStyle(color: Colors.white60, fontSize: 20),
                    ),
                  );
                } else {
                  return CustomTicletList(
                    ticketList: tickets.ticketsToday!,
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
