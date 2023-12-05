import 'dart:ui';

import 'package:design/third.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Loovr3 extends StatefulWidget {
  const Loovr3({super.key});

  @override
  State<Loovr3> createState() => _Loovr3State();
}

class _Loovr3State extends State<Loovr3> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.transparent,
          onPressed: () {},
          child: SvgPicture.asset('lib/image/Frame 117.svg'),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(colors: [
              Color(0xFF006767),
              Color(0xFF000000),
              Color(0xFF000000),
              Color(0xFF000000),
            ], focal: Alignment.topRight, radius: 1.4),
          ),
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 50),
                      child: SvgPicture.asset('lib/image/logo.svg'),
                    ),
                    SelectableText(
                      'знакомства для тех, кто ценит качество',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF).withOpacity(0.50),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Column(
                  children: [
                    ListTile(
                      title: SelectableText(
                        'Политика конфиденциальности',
                        style: TextStyle(color: Color(0xFFC3C3C3)),
                      ),
                      leading: SvgPicture.asset('lib/image/icons (3).svg'),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    ListTile(
                      title: SelectableText(
                        'FAQ',
                        style: TextStyle(color: Color(0xFFC3C3C3)),
                      ),
                      leading: SvgPicture.asset('lib/image/icons (4).svg'),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    ListTile(
                      title: SelectableText(
                        'Связаться с нами',
                        style: TextStyle(color: Color(0xFFC3C3C3)),
                      ),
                      leading: SvgPicture.asset('lib/image/icons (5).svg'),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 390,
              ),
              SelectableText(
                'Loovr App © 2023. All Rights Reserved.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFFFFFFFF).withOpacity(0.50)),
              ),
              SelectableText('Version 0.9.321',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFFFFFFFF).withOpacity(0.50)))
            ],
          ),
        ),
      ),
    );
  }
}
