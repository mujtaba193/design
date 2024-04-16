import 'package:flutter/material.dart';

class Match extends StatefulWidget {
  Match({super.key});

  @override
  State<Match> createState() => _MatchState();
}

class _MatchState extends State<Match> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(colors: [
                  Color(0xFF006767),
                  Color(0xFF000000),
                  Color(0xFF000000),
                  Color(0xFF000000),
                ], focal: Alignment.topRight, radius: 1.4),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(colors: [
                  const Color(0xFF9744D8),
                  const Color(0xFF000000).withOpacity(0),
                  const Color(0xFF000000).withOpacity(0),
                ], focal: Alignment.bottomLeft, radius: 1.4),
              ),
            ),
            Positioned(
              top: 90,
              left: 70,
              child: Image.asset(
                  'lib/image/photo-1530531493359-d9a2d786202d 2.png'),
            ),
            Positioned(
              top: 118,
              right: 70,
              child: Image.asset('lib/image/photo.png'),
            ),
            Positioned(
                top: 240, child: Image.asset('lib/image/Mask group.png')),
            const Text(
              'Вы и Кристина лайкнули друг друга!',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Color(0XFFC3C3C3),
              ),
              textAlign: TextAlign.center,
            ),
            Positioned(
              bottom: 100,
              child: InkWell(
                onTap: () {
                  setState(() {});
                },
                child: Container(
                  width: 290,
                  margin: const EdgeInsets.all(5),
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(30),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF8942BC),
                        Color(0xFF5831F7),
                        Color(0xFF5731F8),
                        Color(0xFF00C2C2),
                      ],
                    ),
                  ),
                  child: const Center(
                      child: Text(
                    'Написать сообщение',
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                    ),
                  )),
                ),
              ),
            ),
            Positioned(
              bottom: 40,
              child: InkWell(
                onTap: () {
                  setState(() {});
                },
                child: Container(
                  width: 290,
                  margin: const EdgeInsets.all(5),
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(30),
                      /* gradient: const LinearGradient(
                      colors: [
                        Color(0xFF8942BC),
                        Color(0xFF5831F7),
                        Color(0xFF5731F8),
                        Color(0xFF00C2C2),
                      ],
                    ),*/
                      color: const Color(0xFF714BD8).withOpacity(0.25)),
                  child: const Center(
                      child: Text(
                    'Продолжить',
                    style: TextStyle(
                        color: Color(0xFF714BD8), fontWeight: FontWeight.w700),
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
