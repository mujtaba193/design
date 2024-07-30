import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

bool vall = true, vall2 = true;

class Loovr extends StatefulWidget {
  const Loovr({super.key});

  @override
  State<Loovr> createState() => _SecondState();
}

class _SecondState extends State<Loovr> with TickerProviderStateMixin {
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
          decoration: const BoxDecoration(
            color: Color(0xFF000000),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 50),
                    child: vall
                        ? SvgPicture.asset('lib/image/logo.svg')
                        : SvgPicture.asset('lib/image/Loovr Elite.svg'),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                vall
                    ? Container(
                        child: const Column(
                          children: [
                            SelectableText(
                              'Бесплатный доступ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w900),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SelectableText(
                              'Базовый функционал',
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    : Container(
                        child: const Column(
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
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {});
                        vall = true;
                      },
                      child: Container(
                        width: 100,
                        margin: const EdgeInsets.all(5),
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(30),
                          gradient: vall
                              ? const LinearGradient(
                                  colors: [
                                    Color(0xFF8942BC),
                                    Color(0xFF5831F7),
                                    Color(0xFF5731F8),
                                    Color(0xFF00C2C2),
                                  ],
                                )
                              : const LinearGradient(
                                  colors: [
                                    Color(0xFF1B1B1B),
                                    Color(0xFF1B1B1B),
                                  ],
                                ),
                        ),
                        child: const Center(
                          child: Text('Бесплатная'),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          //GoRouter.of(context).go("/loover2");
                          vall = false;
                        });
                      },
                      child: Container(
                        width: 100,
                        margin: const EdgeInsets.all(5),
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(30),
                          gradient: vall
                              ? const LinearGradient(
                                  colors: [
                                    Color(0xFF1B1B1B),
                                    Color(0xFF1B1B1B),
                                  ],
                                )
                              : const LinearGradient(
                                  colors: [
                                    Color(0xFF8942BC),
                                    Color(0xFF5831F7),
                                    Color(0xFF5731F8),
                                    Color(0xFF00C2C2),
                                  ],
                                ),
                        ),
                        child: const Center(
                          child: Text('Loovr Elite'),
                        ),
                      ),
                    ),
                  ],
                ),
                vall
                    ? Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 49, 45, 45),
                          border: Border(),
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
                                  SvgPicture.asset('lib/image/Group 140.svg'),
                              title: const SelectableText('Лайки'),
                              subtitle: const SelectableText(
                                  'Ставьте до 50 лайков каждый день'),
                            ),
                            ListTile(
                              leading: SvgPicture.asset(
                                  'lib/image/Group 139 (7).svg'),
                              title: const SelectableText('Поиск по местоположению'),
                              subtitle: const SelectableText(
                                  'Найдите друга по переписке в другом конце планеты или в соседнем доме'),
                            ),
                            ListTile(
                              leading: SvgPicture.asset(
                                  'lib/image/Group 139 (8).svg'),
                              title: const SelectableText('История мэтчей'),
                              subtitle: const SelectableText(
                                  'Вы всегда можете посмотреть, кто ответил на ваш лайк взаимностью'),
                            ),
                            ListTile(
                              leading: SvgPicture.asset(
                                  'lib/image/Group 139 (9).svg'),
                              title: const SelectableText('Безлимитное общение'),
                              subtitle: const SelectableText(
                                  'Общайтесь, обменивайтесь фотографиями с мэтчами'),
                            ),
                            ListTile(
                              leading: SvgPicture.asset(
                                  'lib/image/Group 139 (10).svg'),
                              title: const SelectableText('Лента'),
                              subtitle: const SelectableText(
                                  'Рассказывайте своим мэтчам о том, что у вас сегодня произошло'),
                            )
                          ],
                        ),
                      )
                    : Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
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
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              leading: SvgPicture.asset(
                                  'lib/image/Group 140 (1).svg'),
                              title: const SelectableText('Двойные лайки'),
                              subtitle: const SelectableText('50 → 100 / день'),
                            ),
                            ListTile(
                              leading: SvgPicture.asset(
                                  'lib/image/Group 140 (2).svg'),
                              title: const SelectableText('Суперлайки'),
                              subtitle: const SelectableText(
                                  'Ставьте до 5 суперлайков каждые 12 часов'),
                            ),
                            ListTile(
                              leading: SvgPicture.asset(
                                  'lib/image/Group 139 (11).svg'),
                              title: const SelectableText('Повышенная популярность'),
                              subtitle: const SelectableText(
                                  'Ваша анкета будет попадаться в 3 раза чаще'),
                            ),
                            ListTile(
                              leading: SvgPicture.asset(
                                  'lib/image/Group 139 (12).svg'),
                              title: const SelectableText('Организация свиданий'),
                              subtitle: const SelectableText(
                                  'Расскажите о планах на вечер и выберите, с кем хотите их провести'),
                            ),
                            ListTile(
                              leading: SvgPicture.asset(
                                  'lib/image/Group 139 (13).svg'),
                              title: const SelectableText('Поиск по интересами'),
                              subtitle: const SelectableText(
                                  'Выберите партнера, который разбирается в вашей теме'),
                            ),
                            ListTile(
                              leading: SvgPicture.asset(
                                  'lib/image/Group 139 (14).svg'),
                              title: const SelectableText('Фильтр по возрасту'),
                              subtitle: const SelectableText(
                                  'Вы можете ограничивать по возрасту тех, кто видит вас'),
                            )
                          ],
                        ),
                      ),
                vall
                    ? Container(
                        height: 200,
                        margin: const EdgeInsets.symmetric(),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(30),
                          color: const Color.fromARGB(255, 49, 45, 45),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  vall2 = true;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                height: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(30),
                                  gradient: vall2
                                      ? const LinearGradient(
                                          colors: [
                                            Color(0xFF8942BC),
                                            Color(0xFF5831F7),
                                            Color(0xFF5731F8),
                                            Color(0xFF00C2C2),
                                          ],
                                        )
                                      : const LinearGradient(
                                          colors: [
                                            Color(0xFF696868),
                                            Color(0xFF696868),
                                          ],
                                        ),
                                ),
                                child: const Center(
                                  child: Text('У вас бесплатный доступ'),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  vall2 = false;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                height: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(30),
                                  gradient: vall2
                                      ? const LinearGradient(
                                          colors: [
                                            Color(0xFF696868),
                                            Color(0xFF696868),
                                          ],
                                        )
                                      : const LinearGradient(
                                          colors: [
                                            Color(0xFF8942BC),
                                            Color(0xFF5831F7),
                                            Color(0xFF5731F8),
                                            Color(0xFF00C2C2),
                                          ],
                                        ),
                                ),
                                child: const Center(
                                  child: Text('Перейти на Elite'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        alignment: Alignment.center,
                        height: 200,
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(30),
                          color: const Color.fromARGB(255, 49, 45, 45),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xFF696868),
                                  ),
                                  color: const Color(0xFF000000),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: TabBar(
                                    indicator: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color:
                                          const Color(0xFF714BD8).withOpacity(0.25),
                                    ),
                                    controller: tabController,
                                    isScrollable: true,
                                    labelPadding:
                                        const EdgeInsets.symmetric(horizontal: 10),
                                    labelColor: const Color(0xFF714BD8),
                                    unselectedLabelColor: const Color(0xFF696868),
                                    tabs: const [
                                      Tab(
                                          child: Text(
                                        'Еженедельно',
                                      )),
                                      Tab(
                                          child: Text(
                                        'Ежемесячно',
                                      ))
                                    ]),
                              ),
                              const SizedBox(height: 10),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  margin: const EdgeInsets.all(
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
                                  child: const Center(
                                    child:
                                        Text('Подписаться за 499,00 ₽ / месяц'),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 40),
                              Container(
                                child: const SelectableText(
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
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
