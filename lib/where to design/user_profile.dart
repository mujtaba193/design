import 'dart:io';

import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:design/where%20to%20design/translation/hive_class.dart';
import 'package:design/where%20to%20design/translation/profie_page_translation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final TextEditingController birthdayController = TextEditingController();
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
        title: Text(ProfiePageTranslation.profileSettings),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              Center(
                child: IconButton(
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
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.001,
              ),
              Text(
                ProfiePageTranslation.name,
                style: TextStyle(fontSize: 20),
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
                    hintText: ProfiePageTranslation.hintName,
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
              Text(
                ProfiePageTranslation.birthDate,
                style: TextStyle(fontSize: 20),
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
                  controller: birthdayController,
                  autofocus: true,
                  readOnly: true,
                  textAlign: TextAlign.start,
                  // style: TextStyle(
                  //   fontSize: 14,
                  // ),

                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.edit),
                    hintStyle: TextStyle(fontSize: 14),
                    //  contentPadding: const EdgeInsets.only(left: 0),
                    filled: true,
                    //fillColor: Colors.transparent,
                    // border: AppConstants.outlineInputBorder,
                    // focusedBorder: AppConstants.outlineInputBorder,
                    hintText: ProfiePageTranslation.hintbirthDate,
// border: InputBorder.none,

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return AllTranslation.pleaseSelectYourBirthday;
                  //   }
                  //   return null;
                  // },
                  onTap: () {
                    const duration = Duration(days: 365 * 1 + 4);
                    BottomPicker.date(
                      //  buttonText: CommonTranslations.save,
                      height: 500,
                      // buttonTextStyle:
                      //     const TextStyle(color: Colors.white),
                      initialDateTime: DateTime.now().subtract(duration),
                      maxDateTime: DateTime.now().subtract(duration),
                      minDateTime: DateTime(1925),

                      onChange: (index) {
                        print(index);
                      },
                      onSubmit: (index) {
                        if (index != null) {
                          //    onBirthdaySelected(index);
                          birthdayController.text =
                              DateFormat("dd.MM.yyyy").format(index);
                        }
                      },
                      bottomPickerTheme: BottomPickerTheme.plumPlate,
                      pickerTitle: Text('selcte'),
                    ).show(context);
                  },
                ),
              ),
              Text(
                ProfiePageTranslation.phoneNum,
                style: TextStyle(fontSize: 20),
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
                    hintText: ProfiePageTranslation.hintPhon,
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
              Text(
                ProfiePageTranslation.mail,
                style: TextStyle(fontSize: 20),
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
                    hintText: ProfiePageTranslation.hintMail,
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
              Row(
                children: [Text(ProfiePageTranslation.profileSettings)],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Row(
                children: [
                  Text(ProfiePageTranslation.language),
                  Spacer(),
                  InkWell(
                    child: Text(Hive.box(HiveBox.langbox)
                                    .get(HiveBox.newLang) ==
                                'en' ||
                            Hive.box(HiveBox.langbox).get(HiveBox.newLang) ==
                                null
                        ? 'English'
                        : 'Russian'),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return SimpleDialog(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () async {
                                      Box<dynamic> newLang =
                                          Hive.box(HiveBox.langbox);
                                      await newLang.put(HiveBox.newLang, 'ru');
                                      //   ProfiePageTranslation.languageCode = 'ru';
                                      Navigator.pop(context);
                                      setState(() {});
                                    },
                                    child: const Text(
                                      'русский',
                                      style: TextStyle(
                                        color: Color(0xFFC3C3C3),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Hive.box(HiveBox.langbox)
                                              .get(HiveBox.newLang) ==
                                          'ru'
                                      ? Icon(Icons.check_circle)
                                      : Icon(Icons.circle_outlined)
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () async {
                                      Box<dynamic> newLang =
                                          Hive.box(HiveBox.langbox);
                                      await newLang.put(HiveBox.newLang, 'en');
                                      setState(() {
                                        //  ProfiePageTranslation.languageCode = 'en';
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: const Text(
                                      ' English ',
                                      style: TextStyle(
                                        color: Color(0xFFC3C3C3),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Hive.box(HiveBox.langbox)
                                                  .get(HiveBox.newLang) ==
                                              'en' ||
                                          Hive.box(HiveBox.langbox)
                                                  .get(HiveBox.newLang) ==
                                              null
                                      ? Icon(Icons.check_circle)
                                      : Icon(Icons.circle_outlined)
                                ],
                              ),
                            ],
                          );
                        },
                      );
                    },
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Row(
                children: [Text(ProfiePageTranslation.pushNotifications)],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Row(
                children: [
                  Text(ProfiePageTranslation.bookingInformations),
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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Row(
                children: [
                  Text(ProfiePageTranslation.chatMessage),
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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Row(
                children: [
                  Text(ProfiePageTranslation.news),
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
            ],
          ),
        ),
      ),
    );
  }
}
