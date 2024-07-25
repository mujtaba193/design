import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class PayPage extends StatefulWidget {
  const PayPage({super.key});

  @override
  State<PayPage> createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  int? selectedvalue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // to make bottomanavBar color transparent
      extendBody: true,
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
        height: MediaQuery.of(context).size.height * 0.05,
        width: MediaQuery.of(context).size.width * 0.1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
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
          child: TextButton(
            onPressed: () {},
            child: Text(
                ' ${selectedvalue == null ? 'Select your plan' : 'Pay $selectedvalue'}'),
          ),
        ),
      ),
      appBar: AppBar(
        title: Text('VIP User'),
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
          Center(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                InkWell(
                  onTap: () {
                    setState(() {
                      selectedvalue = 1499;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.07,
                        right: MediaQuery.of(context).size.width * 0.04),
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.9,
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
                      borderRadius: BorderRadius.circular(999),
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
                      child: Row(
                        children: [
                          Text('1499 for 1 day'),
                          Spacer(),
                          selectedvalue == 1499
                              ? Icon(Icons.check_circle)
                              : Icon(Icons.circle_outlined)
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                InkWell(
                  onTap: () {
                    setState(() {
                      selectedvalue = 2499;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.07,
                        right: MediaQuery.of(context).size.width * 0.04),
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.9,
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
                      borderRadius: BorderRadius.circular(999),
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
                        child: Row(
                      children: [
                        Text('2499 for 2 days'),
                        Spacer(),
                        selectedvalue == 2499
                            ? Icon(Icons.check_circle)
                            : Icon(Icons.circle_outlined)
                      ],
                    )),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                InkWell(
                  onTap: () {
                    setState(() {
                      selectedvalue = 6999;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.07,
                        right: MediaQuery.of(context).size.width * 0.04),
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF8942BC),
                          Color(0xFF5831F7),
                          Color(0xFF5731F8),
                          Color(0xFF00C2C2),
                        ],
                      ),
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
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Center(
                      child: Row(
                        children: [
                          Text('6999 for 7 days'),
                          Spacer(),
                          selectedvalue == 6999
                              ? Icon(Icons.check_circle)
                              : Icon(Icons.circle_outlined)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
