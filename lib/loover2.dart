import 'dart:ui';

import 'package:design/third.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Loovr2 extends StatefulWidget {
  const Loovr2({super.key});

  @override
  State<Loovr2> createState() => _Loovr2State();
}

class _Loovr2State extends State<Loovr2> with TickerProviderStateMixin {
  List<bool> isSelected = [true, false];
  //List.generate(2, (index) => false); // 'Еженедельно', 'Ежемесячно'
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);
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
          /* foregroundDecoration: BoxDecoration(
            gradient: RadialGradient(colors: [
              Color(0xFF5831F7),
              // Color(0xFF5731F8),
              Color(0xFF000000),
              Color(0xFF000000),
              Color(0xFF000000),
            ], focal: Alignment.centerLeft, radius: 1.4),
          ),*/
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 50),
                    child: SvgPicture.asset('lib/image/Loovr Elite.svg'),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: Column(
                    children: [
                      SelectableText(
                        'Loovr Elite',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w900),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SelectableText(
                        'Увеличьте лимиты и получите максимум преимуществ с подпиской Loovr Elite!',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          GoRouter.of(context).go("/");
                        });
                      },
                      child: Container(
                        width: 100,
                        margin: EdgeInsets.all(5),
                        height: 40,
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
                        child: Center(child: Text('Бесплатная')),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        width: 100,
                        margin: EdgeInsets.all(5),
                        height: 40,
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
                        child: Center(child: Text('Loovr Elite')),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: GradientBoxBorder(
                      width: 2,
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF8942BC),
                          Color(0xFF5831F7),
                          Color(0xFF5731F8),
                          Color(0xFF00C2C2),
                        ],
                      ),
                    ),
                    color: Color.fromARGB(255, 49, 45, 45),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading:
                            SvgPicture.asset('lib/image/Group 140 (1).svg'),
                        title: SelectableText('Двойные лайки'),
                        subtitle: SelectableText('50 → 100 / день'),
                      ),
                      ListTile(
                        leading:
                            SvgPicture.asset('lib/image/Group 140 (2).svg'),
                        title: SelectableText('Суперлайки'),
                        subtitle: SelectableText(
                            'Ставьте до 5 суперлайков каждые 12 часов'),
                      ),
                      ListTile(
                        leading:
                            SvgPicture.asset('lib/image/Group 139 (11).svg'),
                        title: SelectableText('Повышенная популярность'),
                        subtitle: SelectableText(
                            'Ваша анкета будет попадаться в 3 раза чаще'),
                      ),
                      ListTile(
                        leading:
                            SvgPicture.asset('lib/image/Group 139 (12).svg'),
                        title: SelectableText('Организация свиданий'),
                        subtitle: SelectableText(
                            'Расскажите о планах на вечер и выберите, с кем хотите их провести'),
                      ),
                      ListTile(
                        leading:
                            SvgPicture.asset('lib/image/Group 139 (13).svg'),
                        title: SelectableText('Поиск по интересами'),
                        subtitle: SelectableText(
                            'Выберите партнера, который разбирается в вашей теме'),
                      ),
                      ListTile(
                        leading:
                            SvgPicture.asset('lib/image/Group 139 (14).svg'),
                        title: SelectableText('Фильтр по возрасту'),
                        subtitle: SelectableText(
                            'Вы можете ограничивать по возрасту тех, кто видит вас'),
                      )
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 200,
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(30),
                    color: Color.fromARGB(255, 49, 45, 45),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xFF696868),
                            ),
                            color: Color(0xFF000000),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TabBar(
                              indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Color(0xFF714BD8).withOpacity(0.25),
                              ),
                              controller: tabController,
                              isScrollable: true,
                              labelPadding:
                                  EdgeInsets.symmetric(horizontal: 30),
                              labelColor: Color(0xFF714BD8),
                              unselectedLabelColor: Color(0xFF696868),
                              tabs: [
                                Tab(
                                    child: Text(
                                  'Еженедельно',
                                )),
                                Tab(
                                    child: Text(
                                  'Еженедельно',
                                ))
                              ]),
                        ),
                        /* ToggleButtons(
                          direction: Axis.horizontal,
                          constraints: BoxConstraints.tight(Size(165, 50)),
                          verticalDirection: VerticalDirection.up,
                          color: Color(0xFF000000),
                          borderWidth: 1,
                          borderRadius: BorderRadius.circular(999),
                          fillColor: Color(0xFF714BD8).withOpacity(0.25),
                          selectedColor: Color(0xFF000000),
                          borderColor: Color(0xFF714BD8),
                          children: [
                            Text(
                              'Еженедельно',
                              style: TextStyle(
                                color: Color(0xFF696868),
                              ),
                            ),
                            Text(
                              'Ежемесячно',
                              style: TextStyle(
                                color: Color(0xFF696868),
                              ),
                            ),
                          ],
                          isSelected: isSelected,
                          onPressed: (int index) {
                            setState(() {
                              for (int i = 0; i < isSelected.length; i++) {
                                if (i == index) {
                                  isSelected[i] = true;
                                } else {
                                  isSelected[i] = false;
                                }
                              }
                            });
                          },
                        ),*/
                        SizedBox(height: 10),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.all(
                                5), // 'Еженедельно', 'Ежемесячно'
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
                              child: Text('Подписаться за 499,00 ₽ / месяц'),
                            ),
                          ),
                        ),
                        SizedBox(width: 40),
                        Container(
                          child: SelectableText(
                            'Оформляя подписку на Loovr EliteВы соглашаетесь с правилами использования и Политикой конфиденциальности',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
