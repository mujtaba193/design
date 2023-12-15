import 'dart:ui';

import 'package:design/third.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Register1 extends StatefulWidget {
  const Register1({super.key});

  @override
  State<Register1> createState() => _Register1State();
}

class _Register1State extends State<Register1> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF000000),
          title: Text(
            'Регистрация',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.w700,
            ),
          ),
          leading: BackButton(
            style: ButtonStyle(),
            onPressed: () {},
          ),
        ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(colors: [
                  Color(0xFF9744D8),
                  Color(0xFF000000),
                  Color(0xFF000000),
                  Color(0xFF000000),
                ], focal: Alignment.topRight, radius: 1.4),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(colors: [
                  Color(0xFF006767),
                  Color(0xFF000000).withOpacity(0),
                  Color(0xFF000000).withOpacity(0),
                ], focal: Alignment.bottomLeft, radius: 1.4),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 25, top: 30),
                  child: LinearPercentIndicator(
                    width: 360,
                    percent: 0.1,
                    lineHeight: 8.0,
                    backgroundColor: Color(0xFFFFFFFF).withOpacity(0.20),
                    barRadius: Radius.circular(30),
                    progressColor: Color(0xFF9744D8),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Шаг 8 из 8',
                  style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFFFFFFFF),
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Купите премиум',
                  style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFFFFFFFF),
                      fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Ну пожалуйста',
                  style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFFFFFFFF),
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 400,
                ),
                InkWell(
                  onTap: () {
                    setState(() {});
                  },
                  child: Container(
                    width: 290,
                    margin: EdgeInsets.all(5),
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
                    child: Center(
                        child: Text(
                      'Купить за 1 990 ₽ / мес',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                      ),
                    )),
                  ),
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    setState(() {});
                  },
                  child: Container(
                    width: 290,
                    margin: EdgeInsets.all(5),
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
                    child: Center(
                        child: Text(
                      'Продолжить',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                      ),
                    )),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
