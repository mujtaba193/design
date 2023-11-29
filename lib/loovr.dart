import 'package:design/third.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

int val = 1;

class Loovr extends StatefulWidget {
  const Loovr({super.key});

  @override
  State<Loovr> createState() => _SecondState();
}

class _SecondState extends State<Loovr> {
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
            color: Color(0xFF000000),
          ),
          child: Column(
            children: [
              Center(
                child: Container(
                  child: SvgPicture.asset('lib/image/logo.svg'),
                  margin: EdgeInsets.only(top: 50),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: Column(
                  children: [
                    SelectableText(
                      'Бесплатный доступ',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
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
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                      child: Center(
                        child: SelectableText('Бесплатная'),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        GoRouter.of(context).go("/loover2");
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
                      child: Center(child: SelectableText('Loovr Elite')),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
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
                      leading: SvgPicture.asset('lib/image/Group 140.svg'),
                      title: SelectableText('Лайки'),
                      subtitle:
                          SelectableText('Ставьте до 50 лайков каждый день'),
                    ),
                    ListTile(
                      leading: SvgPicture.asset('lib/image/Group 139 (7).svg'),
                      title: SelectableText('Поиск по местоположению'),
                      subtitle: SelectableText(
                          'Найдите друга по переписке в другом конце планеты или в соседнем доме'),
                    ),
                    ListTile(
                      leading: SvgPicture.asset('lib/image/Group 139 (8).svg'),
                      title: SelectableText('История мэтчей'),
                      subtitle: SelectableText(
                          'Вы всегда можете посмотреть, кто ответил на ваш лайк взаимностью'),
                    ),
                    ListTile(
                      leading: SvgPicture.asset('lib/image/Group 139 (9).svg'),
                      title: SelectableText('Безлимитное общение'),
                      subtitle: SelectableText(
                          'Общайтесь, обменивайтесь фотографиями с мэтчами'),
                    ),
                    ListTile(
                      leading: SvgPicture.asset('lib/image/Group 139 (10).svg'),
                      title: SelectableText('Лента'),
                      subtitle: SelectableText(
                          'Рассказывайте своим мэтчам о том, что у вас сегодня произошло'),
                    )
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

class FreePay extends StatefulWidget {
  const FreePay({super.key});

  @override
  State<FreePay> createState() => _FreePayState();
}

class _FreePayState extends State<FreePay> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 49, 45, 45),
        border: Border.all(),
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
            leading: SvgPicture.asset('lib/image/Group 140.svg'),
            title: SelectableText('Лайки'),
            subtitle: SelectableText('Ставьте до 50 лайков каждый день'),
          ),
          ListTile(
            leading: SvgPicture.asset('lib/image/Group 139 (7).svg'),
            title: SelectableText('Поиск по местоположению'),
            subtitle: SelectableText(
                'Найдите друга по переписке в другом конце планеты или в соседнем доме'),
          ),
          ListTile(
            leading: SvgPicture.asset('lib/image/Group 139 (8).svg'),
            title: SelectableText('История мэтчей'),
            subtitle: SelectableText(
                'Вы всегда можете посмотреть, кто ответил на ваш лайк взаимностью'),
          ),
          ListTile(
            leading: SvgPicture.asset('lib/image/Group 139 (9).svg'),
            title: SelectableText('Безлимитное общение'),
            subtitle: SelectableText(
                'Общайтесь, обменивайтесь фотографиями с мэтчами'),
          ),
          ListTile(
            leading: SvgPicture.asset('lib/image/Group 139 (10).svg'),
            title: SelectableText('Лента'),
            subtitle: SelectableText(
                'Рассказывайте своим мэтчам о том, что у вас сегодня произошло'),
          )
        ],
      ),
    );
  }
}
/*  Container(
                width: 200,
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
                    )),
              ),*/ 