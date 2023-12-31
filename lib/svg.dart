import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

String tt = "Подписаться за 1990 ₽ / год";

class Svgg extends StatefulWidget {
  const Svgg({super.key});

  @override
  State<Svgg> createState() => _SvggState();
}

class _SvggState extends State<Svgg> {
  String? count;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.transparent,
          elevation: 0,
          onPressed: () {
            //GoRouter.of(context).go("/");
            //context.go("/");
          },
          child: SvgPicture.asset(
            'lib/image/Frame 117.svg',
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(colors: [
              //Color(0xFF8942BC),
              Color(0xFF5831F7),
              // Color(0xFF5731F8),
              Color(0xFF000000),
              Color(0xFF000000),
              Color(0xFF000000),
            ], focal: Alignment.topLeft, radius: 1.4),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: SvgPicture.asset('lib/image/icons (1).svg'),
                  ),
                ),
                Container(
                  child: const SelectableText(
                    'Loovr Elite',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(30, 10, 30, 15),
                  child: const SelectableText(
                    'Увеличьте лимиты и получите максимум преимуществ с подпиской Loovr Elite!',
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 49, 45, 45),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: const Color.fromARGB(255, 134, 133, 133),
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        margin: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            RadioListTile(
                              contentPadding:
                                  const EdgeInsets.only(left: 0, right: 10),
                              title: const SelectableText('Годовая'),
                              secondary: const SelectableText(
                                '199,00 ₽ / мес',
                                style: TextStyle(
                                  color: Color(0xFFC3C3C3),
                                ),
                              ),
                              value: "199,00 ₽ / мес",
                              groupValue: count,
                              onChanged: (val) {
                                setState(() {
                                  count = val;
                                  if (count == "199,00 ₽ / мес") {
                                    tt = count.toString();
                                  }
                                });
                              },
                            ),
                            RadioListTile(
                                contentPadding:
                                    const EdgeInsets.only(left: 0, right: 10),
                                title: const SelectableText('Ежемесячная'),
                                secondary: const SelectableText(
                                  '236,92 ₽ / мес',
                                  style: TextStyle(
                                    color: Color(0xFFC3C3C3),
                                  ),
                                ),
                                value: "236,92 ₽ / мес",
                                groupValue: count,
                                onChanged: (val) {
                                  setState(
                                    () {
                                      count = val;

                                      if (count == "236,92 ₽ / мес") {
                                        tt = count.toString();
                                      }
                                    },
                                  );
                                }),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 10, 40, 10),
                        child: Column(
                          children: [
                            ListTile(
                              leading:
                                  SvgPicture.asset('lib/image/Group 139.svg'),
                              title: const SelectableText('Организация встреч'),
                              subtitle: const SelectableText(
                                  'Расскажите о планах на вечер и выберите, с кем хотите их провести'),
                            ),
                            ListTile(
                              leading: SvgPicture.asset(
                                  'lib/image/Group 139 (2).svg'),
                              title: const SelectableText('Двойные свайпы'),
                              subtitle: const SelectableText('50 → 100 / день'),
                            ),
                            ListTile(
                              leading: SvgPicture.asset(
                                  'lib/image/Group 139 (3).svg'),
                              title: const SelectableText('Суперлайки'),
                              subtitle: const SelectableText(
                                  'Ставьте до 50 суперлайков в день'),
                            ),
                            ListTile(
                              leading: SvgPicture.asset(
                                  'lib/image/Group 139 (4).svg'),
                              title: const SelectableText('Ранний доступ'),
                              subtitle: const SelectableText(
                                  'Опробуйте новые функции приложения первым!'),
                            ),
                            ListTile(
                              leading: SvgPicture.asset(
                                  'lib/image/Group 139 (5).svg'),
                              title: const SelectableText('Приоритетная поддержка'),
                              subtitle: const SelectableText(
                                  'Ответим на любой вопрос вне очереди'),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: const SelectableText(
                          'Оформляя подписку на Loovr EliteВы соглашаетесь с правилами использования и Политикой конфиденциальности',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          GoRouter.of(context).go("/value");
                        },
                        child: Container(
                          width: 250,
                          margin: const EdgeInsets.all(5),
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
                          child: Center(child: SelectableText(tt)),
                        ),
                      ),
                    ],
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
// 'Подписаться за 1990 ₽ / год.'