import 'package:flutter/material.dart';

import 'shwo_tickets_list.dart';
import 'tickets_after_today.dart';
import 'tickets_befor_today.dart';

class TicketsAllPages extends StatefulWidget {
  const TicketsAllPages({super.key});

  @override
  State<TicketsAllPages> createState() => _TicketsAllPagesState();
}

class _TicketsAllPagesState extends State<TicketsAllPages> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.list),
              ),
              Tab(
                icon: Icon(Icons.receipt_sharp),
              ),
              Tab(
                icon: Icon(Icons.list),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ShowTicketsList(),
            ShowAfterTodayTickets(),
            ShowBeforTodayTickets()
          ],
        ),
      ),
    );
  }
}
