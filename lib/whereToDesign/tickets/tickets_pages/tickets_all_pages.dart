import 'package:design/appconfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'show_tickets_application.dart';
import 'tickets_after_today.dart';
import 'tickets_befor_today.dart';

class TicketsAllPages extends StatefulWidget {
  const TicketsAllPages({super.key});

  @override
  State<TicketsAllPages> createState() => _TicketsAllPagesState();
}

class _TicketsAllPagesState extends State<TicketsAllPages>
    with TickerProviderStateMixin {
  late TabController _controller;
  int _selectedTabIndex = 0;
  @override
  void initState() {
    _controller =
        TabController(length: 3, vsync: this, initialIndex: _selectedTabIndex);
    _controller.addListener(() {
      setState(() {
        _selectedTabIndex = _controller.index;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: _selectedTabIndex,
      length: 3,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
              // logo of the app.
              leading: Image.asset(
                'assets/logo1.png',
              ),
              title: Text(
                'Search a boat',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppConfig.fontColor),
              ),
              actions: [
                Text(
                  'Login',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppConfig.fontColor2),
                ),
                SizedBox(
                  width: 6,
                ),
                //Icon of Login.
                SvgPicture.asset('assets/LoginVector.svg'),
                SizedBox(
                  width: 16,
                )
              ],
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(kToolbarHeight),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // Set the background color to red
                      borderRadius:
                          BorderRadius.circular(10), // Set the border radius
                    ),
                    padding: EdgeInsets.all(8), // Add padding
                    child: TabBar(
                      controller: _controller,
                      labelPadding: EdgeInsets.all(0),
                      dividerColor: Colors.transparent,
                      indicatorColor: Colors.transparent,
                      padding: EdgeInsets.all(8),
                      splashBorderRadius: BorderRadius.circular(8),
                      labelColor: AppConfig.fontColor,
                      unselectedLabelColor: AppConfig.fontColor2,
                      tabs: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _controller.index = 0;
                              _selectedTabIndex = 0;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: _selectedTabIndex == 0
                                    ? AppConfig.tabActiveColoar
                                    : null),
                            height: 40,
                            child: Center(
                              child: Text(
                                'Applications(2/3)',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _controller.index = 1;
                              _selectedTabIndex = 1;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: _selectedTabIndex == 1
                                    ? AppConfig.tabActiveColoar
                                    : null),
                            height: 40,
                            child: Center(child: Text('Booking')),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _controller.index = 2;
                              _selectedTabIndex = 2;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: _selectedTabIndex == 2
                                    ? AppConfig.tabActiveColoar
                                    : null),
                            height: 40,
                            child: Center(child: Text('Archive')),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
          body: TabBarView(
            controller: _controller,
            children: [
              ShowTicketsApplication(),
              // TicketsToday(),
              ShowAfterTodayTickets(),
              TicketBeforeToday()
            ],
          ),
        ),
      ),
    );
  }
}
