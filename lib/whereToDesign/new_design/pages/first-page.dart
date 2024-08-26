import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class SliverBar extends StatefulWidget {
  const SliverBar({super.key});

  @override
  State<SliverBar> createState() => _SliverBarState();
}

class _SliverBarState extends State<SliverBar> {
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      physics: BouncingScrollPhysics(),
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverAppBar(
              stretch: true,
              pinned: true,
              floating: true,
              elevation: 0,
              collapsedHeight: 90,
              leading: Icon(Icons.arrow_back_ios),
              title: Text(
                'Sliver ',
              ),
              expandedHeight: 200.0,
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: <StretchMode>[
                  StretchMode.zoomBackground,
                  StretchMode.blurBackground,
                ],
                title: Text(
                  'VIP User ',
                ),
                background: Stack(
                  fit: StackFit.expand,
                  clipBehavior: Clip.none,
                  // fit: StackFit.expand,
                  children: [
                    Image.network(
                      'https://www.23mayfield.co.uk/images/internals/edinburgh.jpg',
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 20,
                      left: MediaQuery.of(context).size.width / 4,
                      child: Opacity(
                        opacity: (0.9),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(999),
                          child: SvgPicture.asset(
                            'lib/image/profile-default.svg',
                            height: 200,
                            width: MediaQuery.of(context).size.width / 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ];
      },
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return ScrollablePositionedList.builder(
            shrinkWrap: true,
            itemCount: 8,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 300,
                  color: Colors
                      .primaries[Random().nextInt(Colors.primaries.length)],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
