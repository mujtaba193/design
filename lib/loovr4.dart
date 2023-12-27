
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Loovr4 extends StatefulWidget {
  const Loovr4({super.key});

  @override
  State<Loovr4> createState() => _Loovr4State();
}

class _Loovr4State extends State<Loovr4> {
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
        body: Stack(
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
                    height: 50,
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 30,
                    ),
                    child: SvgPicture.asset(
                      'lib/image/Vector (1).svg',
                      color: const Color(0xFFFFFFFF).withOpacity(0.50),
                      width: 64,
                      height: 64,
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  const Column(
                    children: [
                      SizedBox(
                        width: 160,
                        child: SelectableText(
                          'Ваш аккаунт деактивирован',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 280,
                        child: SelectableText(
                          'Вы запросили удаление аккаунта. Сейчас ваша анкета скрыта из выдачи, но вы можете успеть восстановить его сейчас.',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Color(0xFFC3C3C3), fontSize: 13),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 280,
                        child: SelectableText(
                          'Аккаунт удалится полностьючерез 26 дней.',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Color(0xFFC3C3C3), fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  InkWell(
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
                        'Восстановить аккаунт',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                        ),
                      )),
                    ),
                  ),
                  InkWell(
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
                        'Выйти из аккаунта',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                        ),
                      )),
                    ),
                  ),
                ],
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
          ],
        ),
      ),
    );
  }
}
