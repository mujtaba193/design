import 'dart:io';
import 'dart:ui';

import 'package:design/third.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:image_picker/image_picker.dart';

class Register3 extends StatefulWidget {
  const Register3({super.key});

  @override
  State<Register3> createState() => _Register3State();
}

class _Register3State extends State<Register3> {
  File? file;
  String? imagePath;

  Future takeFromCamera(context) async {
    XFile? xfile = await ImagePicker().pickImage(source: ImageSource.camera);
    File image = File(xfile!.path);

    setState(() {
      file = image;
    });
  }

  Future takeFromGallary(context) async {
    XFile? xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    File image = File(xfile!.path);

    setState(() {
      file = image;
    });
  }

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
                  'Добавьте ещё фото!',
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
                  'Повысьте шансы получить больше ',
                  style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFFC3C3C3),
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'внимания! Загрузите свои фотографии',
                  style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFFC3C3C3),
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 3, color: Colors.red)),
                  height: 258,
                  width: 310,
                  padding: EdgeInsets.all(5),
                  child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                    ),
                    children: [
                      Container(
                        // padding: EdgeInsets.fromLTRB(14, 24, 14, 24),
                        width: 8,
                        height: 130,
                        decoration: BoxDecoration(
                          border: GradientBoxBorder(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFF8942BC),
                                Color(0xFF5831F7),
                                Color(0xFF5731F8),
                                Color(0xFF00C2C2),
                              ],
                            ),
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Center(
                          child: file == null
                              ? IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return SimpleDialog(
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                setState(() {
                                                  takeFromCamera(context);
                                                });
                                              },
                                              child: Text(
                                                  'choose Image from camera'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                setState(() {
                                                  takeFromGallary(context);
                                                });
                                              },
                                              child: Text(
                                                  'choose Image from Gallery'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  icon: Icon(Icons.add),
                                )
                              : Stack(
                                  children: [
                                    FittedBox(
                                      alignment: Alignment.center,
                                      fit: BoxFit.cover,
                                      child: Image.file(
                                        file!,
                                        width: 130,
                                        height: 130,
                                      ),
                                    ),
                                    Positioned(
                                      left: 62,
                                      bottom: 62,
                                      child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            file = null;
                                          });
                                        },
                                        icon: SvgPicture.asset(
                                            'lib/image/close-circle-fill.svg'),
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Загружено 1 из 6 фотографий',
                  style: TextStyle(
                      color: Color(0xFF696868), fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Вы сможете загрузить фотографии позже.',
                  style: TextStyle(
                      color: Color(0xFFC3C3C3), fontWeight: FontWeight.w400),
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
                        'Продолжить',
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
