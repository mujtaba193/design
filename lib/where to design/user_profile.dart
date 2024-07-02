import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:image_picker/image_picker.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final TextEditingController mycontroller = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phonController = TextEditingController();
  final TextEditingController mailController = TextEditingController();
  bool infoSwitched = false;
  bool mailSwitched = false;
  bool newsSwitched = false;
  File? file;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future takeFromCamera(
    context,
  ) async {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Настройки Профиля'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Center(
              child: Container(
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
                  borderRadius: BorderRadius.circular(999),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: file == null
                      ? SvgPicture.asset(
                          'lib/image/profile-default.svg',
                          width: MediaQuery.of(context).size.width * 0.666,
                          height: MediaQuery.of(context).size.width * 0.666,
                        )
                      : Image.file(
                          file!,
                          width: MediaQuery.of(context).size.width * 0.666,
                          height: MediaQuery.of(context).size.width * 0.666,
                          fit: BoxFit.fill,
                        ),
                ),
              ),
            ),
            IconButton(
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
                            child: const Text(
                              'choose Image from camera',
                              style: TextStyle(
                                color: Color(0xFFC3C3C3),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              setState(() {
                                takeFromGallary(context);
                              });
                            },
                            child: const Text(
                              'choose Image from Gallery',
                              style: TextStyle(
                                color: Color(0xFFC3C3C3),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: Icon(Icons.add_a_photo)),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.001,
            ),
            Padding(
              padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.74),
              child: Text(
                'Имя',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
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
                borderRadius: BorderRadius.circular(30),
              ),
              width: MediaQuery.of(context).size.width * 0.95,
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.edit),
                  hintText: 'Введите ваше имя',
                  hintStyle: const TextStyle(
                    fontSize: 14,
                  ),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Padding(
              padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.65),
              child: Text(
                'Телефон',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
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
                borderRadius: BorderRadius.circular(30),
              ),
              width: MediaQuery.of(context).size.width * 0.95,
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: phonController,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.edit),
                  hintText: 'Введите свой номер телефона',
                  hintStyle: const TextStyle(
                    fontSize: 14,
                  ),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Padding(
              padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.70),
              child: Text(
                'почта',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
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
                borderRadius: BorderRadius.circular(30),
              ),
              width: MediaQuery.of(context).size.width * 0.95,
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: mailController,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.edit),
                  hintText: 'Введите свою электронную почту',
                  hintStyle: const TextStyle(
                    fontSize: 14,
                  ),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.02),
              child: Row(
                children: [Text('Настройки Профиля')],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.02,
                  right: MediaQuery.of(context).size.width * 0.01),
              child: Row(
                children: [Text('язык'), Spacer(), Text('русский')],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.02),
              child: Row(
                children: [Text('push-уведомление')],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.01),
              child: Row(
                children: [
                  Text('информация о бронированию'),
                  Spacer(),
                  CupertinoSwitch(
                    value: infoSwitched,
                    onChanged: (value) {
                      setState(() {
                        infoSwitched = value;
                      });
                    },
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.01),
              child: Row(
                children: [
                  Text('Собщения в чате'),
                  Spacer(),
                  CupertinoSwitch(
                    value: mailSwitched,
                    onChanged: (mailValue) {
                      setState(() {
                        mailSwitched = mailValue;
                      });
                    },
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.01),
              child: Row(
                children: [
                  Text('Новости и акции'),
                  Spacer(),
                  CupertinoSwitch(
                    value: newsSwitched,
                    onChanged: (value) {
                      setState(() {
                        newsSwitched = value;
                      });
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
