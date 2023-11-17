import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Svgg extends StatefulWidget {
  const Svgg({super.key});

  @override
  State<Svgg> createState() => _SvggState();
}

class _SvggState extends State<Svgg> {
  String? count;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
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
              Container(
                margin: EdgeInsets.only(top: 30),
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    'lib/image/Frame 117.svg',
                    height: 50,
                  ),
                ),
              ),
              Center(
                child: Container(
                  child: SvgPicture.asset('lib/image/icons (1).svg'),
                  margin: EdgeInsets.only(top: 10),
                ),
              ),
              Container(
                child: Text(
                  'Loovr Elite',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(30, 10, 30, 15),
                child: Text(
                  'Увеличьте лимиты и получите максимум преимуществ с подпиской Loovr Elite!',
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                decoration: BoxDecoration(
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
                      margin: EdgeInsets.all(15),
                      child: Column(
                        children: [
                          RadioListTile(
                            contentPadding: EdgeInsets.only(left: 0, right: 10),
                            title: Text('Годовая'),
                            secondary: Text(
                              '199,00 ₽ / мес',
                              style: TextStyle(
                                color: Color(0xFFC3C3C3),
                              ),
                            ),
                            value: "199,00",
                            groupValue: count,
                            onChanged: (val) {
                              setState(() {
                                count = val;
                              });
                            },
                          ),
                          RadioListTile(
                              contentPadding:
                                  EdgeInsets.only(left: 0, right: 10),
                              title: Text('Ежемесячная'),
                              secondary: Text(
                                '236,92 ₽ / мес',
                                style: TextStyle(
                                  color: Color(0xFFC3C3C3),
                                ),
                              ),
                              value: "236,92",
                              groupValue: count,
                              onChanged: (val) {
                                setState(() {
                                  count = val;
                                  if (count == "236,92 ₽ / мес") {}
                                });
                              }),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 40, 10),
                      child: Column(
                        children: [
                          ListTile(
                            leading:
                                SvgPicture.asset('lib/image/Group 139.svg'),
                            title: Text('Организация встреч'),
                            subtitle: Text(
                                'Расскажите о планах на вечер и выберите, с кем хотите их провести'),
                          ),
                          ListTile(
                            leading:
                                SvgPicture.asset('lib/image/Group 139 (2).svg'),
                            title: Text('Двойные свайпы'),
                            subtitle: Text('50 → 100 / день'),
                          ),
                          ListTile(
                            leading:
                                SvgPicture.asset('lib/image/Group 139 (3).svg'),
                            title: Text('Суперлайки'),
                            subtitle: Text('Ставьте до 50 суперлайков в день'),
                          ),
                          ListTile(
                            leading:
                                SvgPicture.asset('lib/image/Group 139 (4).svg'),
                            title: Text('Ранний доступ'),
                            subtitle: Text(
                                'Опробуйте новые функции приложения первым!'),
                          ),
                          ListTile(
                            leading:
                                SvgPicture.asset('lib/image/Group 139 (5).svg'),
                            title: Text('Приоритетная поддержка'),
                            subtitle:
                                Text('Ответим на любой вопрос вне очереди'),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'Оформляя подписку на Loovr EliteВы соглашаетесь с правилами использования и Политикой конфиденциальности',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        width: 250,
                        margin: EdgeInsets.all(5),
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF8942BC),
                              Color(0xFF5831F7),
                              Color(0xFF5731F8),
                              Color(0xFF00C2C2),
                            ],
                          ),
                        ),
                        child:
                            Center(child: Text('Подписаться за 1990 ₽ / год.')),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
