import 'package:flutter/material.dart';

import 'about_page.dart';
import 'couresIntake_page.dart';
import 'courseDuration_page.dart';
import 'courseEligibility_page.dart';
import 'entranceRequired_page.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        body: NestedScrollView(
          // controller: _controller,
          physics: BouncingScrollPhysics(),
          headerSliverBuilder: (context, innerScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  centerTitle: true,
                  pinned: true,
                  stretch: true,
                  title: Text('username'),
                  expandedHeight: 325,
                  flexibleSpace: FlexibleSpaceBar(
                    stretchModes: <StretchMode>[
                      StretchMode.zoomBackground,
                      StretchMode.blurBackground,
                    ],
                    background: Image.network(
                        'https://www.23mayfield.co.uk/images/internals/edinburgh.jpg',
                        fit: BoxFit.cover),
                  ),
                  bottom: TabBar(
                    tabs: <Widget>[
                      Text('About'),
                      Text('Intake'),
                      Text('Theird'),
                      Text('Fourth'),
                      Text('Fifth'),
                      Text('Sixth'),
                      Text('Seventh'),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              Center(
                child: Builder(
                  builder: (context) => CustomScrollView(
                    //  controller: _controller,
                    slivers: <Widget>[
                      SliverOverlapInjector(
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                  context)),
                      SliverFixedExtentList(
                          delegate: SliverChildBuilderDelegate(
                              (_, index) => Text('not working'),
                              childCount: 30),
                          itemExtent: 30)
                    ],
                  ),
                ),
              ),
              Center(child: Text('working')),
              AboutPage(),
              Center(child: CouresIntake()),
              Center(child: CourseDuration()),
              Center(child: EntranceRequired()),
              Center(child: CourseEligibility()),
            ],
          ),
        ),
      ),
    );
  }
}
