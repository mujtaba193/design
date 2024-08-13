import 'package:flutter/material.dart';

import 'tickets_after_today.dart';
import 'tickets_befor_today.dart';
import 'tickets_today.dart';

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
                icon: Icon(
                  Icons.airplane_ticket,
                  color: Color.fromARGB(255, 70, 91, 109),
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.airplane_ticket_sharp,
                  color: Color.fromARGB(255, 59, 101, 138),
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.airplane_ticket_outlined,
                  color: Color.fromARGB(255, 37, 90, 114),
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            TicketsToday(),
            ShowAfterTodayTickets(),
            ShowBeforTodayTickets()
          ],
        ),
      ),
    );
  }
}
