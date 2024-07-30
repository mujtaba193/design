
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
          decoration: const BoxDecoration(
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
                      margin: const EdgeInsets.only(top: 50),
                      child: SvgPicture.asset('lib/image/logo.svg'),
                    ),
                    SelectableText(
                      'знакомства для тех, кто ценит качество',
                      style: TextStyle(
                        color: const Color(0xFFFFFFFF).withOpacity(0.50),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                child: Column(
                  children: [
                    ListTile(
                      title: const SelectableText(
                        'Политикаконфиденциальности',
                        style: TextStyle(color: Color(0xFFC3C3C3)),
                      ),
                      leading: SvgPicture.asset('lib/image/icons (3).svg'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                    ListTile(
                      title: const SelectableText(
                        'FAQ',
                        style: TextStyle(color: Color(0xFFC3C3C3)),
                      ),
                      leading: SvgPicture.asset('lib/image/icons (4).svg'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                    ListTile(
                      title: const SelectableText(
                        'Связаться с нами',
                        style: TextStyle(color: Color(0xFFC3C3C3)),
                      ),
                      leading: SvgPicture.asset('lib/image/icons (5).svg'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 390,
              ),
              SelectableText(
                'Loovr App © 2023. All Rights Reserved.',
                textAlign: TextAlign.center,
                style: TextStyle(color: const Color(0xFFFFFFFF).withOpacity(0.50)),
              ),
              SelectableText('Version 0.9.321',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: const Color(0xFFFFFFFF).withOpacity(0.50)))
            ],
          ),
        ),
      ),
    );
  }
}
