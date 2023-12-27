
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Register2 extends StatefulWidget {
  const Register2({super.key});

  @override
  State<Register2> createState() => _Register2State();
}

class _Register2State extends State<Register2> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF000000),
          title: const Text(
            'Регистрация',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.w700,
            ),
          ),
          leading: BackButton(
            style: const ButtonStyle(),
            onPressed: () {},
          ),
        ),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
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
                  const Color(0xFF006767),
                  const Color(0xFF000000).withOpacity(0),
                  const Color(0xFF000000).withOpacity(0),
                ], focal: Alignment.bottomLeft, radius: 1.4),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25, top: 30),
                  child: LinearPercentIndicator(
                    width: 360,
                    percent: 0.1,
                    lineHeight: 8.0,
                    backgroundColor: const Color(0xFFFFFFFF).withOpacity(0.20),
                    barRadius: const Radius.circular(30),
                    progressColor: const Color(0xFF9744D8),
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
                const Text(
                  'Регистрация завершена!',
                  style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFFFFFFFF),
                      fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Поздравляем! Вы зарегистрировали ',
                  style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFFC3C3C3),
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
                const Text(
                  'аккаунт в приложении Loovr!',
                  style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFFC3C3C3),
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
                const Text(
                  'Теперь расскажем, как им пользоваться. ',
                  style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFFC3C3C3),
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 400,
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
                        'Завершить',
                        style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.w700,
                            fontSize: 14),
                      ),
                    ),
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
