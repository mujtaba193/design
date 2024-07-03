import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Register3 extends StatefulWidget {
  const Register3({super.key});

  @override
  State<Register3> createState() => _Register3State();
}

class _Register3State extends State<Register3> {
  File? file;
  File? file1;
  File? file2;
  File? file3;
  File? file4;
  File? file5;
  int? value;
  List<File> files = [];

  Future takeFromCamera(
    context,
  ) async {
    XFile? xfile = await ImagePicker().pickImage(source: ImageSource.camera);
    File image = File(xfile!.path);

    setState(() {
      if (value == 0) {
        file = image;
      }
      if (value == 1) {
        file1 = image;
      }
      if (value == 2) {
        file2 = image;
      }
      if (value == 3) {
        file3 = image;
      }
      if (value == 4) {
        file4 = image;
      }
      if (value == 5) {
        file5 = image;
      }
    });
  }

  Future takeFromGallary(context) async {
    XFile? xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    File image = File(xfile!.path);

    setState(() {
      if (value == 0) {
        file = image;
      } else if (value == 1) {
        file1 = image;
      } else if (value == 2) {
        file2 = image;
      } else if (value == 3) {
        file3 = image;
      } else if (value == 4) {
        file4 = image;
      } else if (value == 5) {
        file5 = image;
      }
    });
  }

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
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 30),
                    child: LinearPercentIndicator(
                      width: 360,
                      percent: 0.1,
                      lineHeight: 8.0,
                      backgroundColor:
                          const Color(0xFFFFFFFF).withOpacity(0.20),
                      barRadius: const Radius.circular(30),
                      progressColor: const Color(0xFF9744D8),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'Шаг 8 из 8',
                    style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'Добавьте ещё фото!',
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
                    'Повысьте шансы получить больше ',
                    style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFFC3C3C3),
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    'внимания! Загрузите свои фотографии',
                    style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFFC3C3C3),
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 320,
                    width: 310,
                    padding: const EdgeInsets.all(5),
                    child: GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.63,
                        crossAxisCount: 3,
                        mainAxisSpacing: 6,
                        crossAxisSpacing: 8,
                      ),
                      children: [
                        Expanded(
                          child: Container(
                            // padding: EdgeInsets.fromLTRB(14, 24, 14, 24),
                            decoration: const BoxDecoration(
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
                                                      value = 0;
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
                                                      value = 0;
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
                                      icon: const Icon(Icons.add),
                                    )
                                  : Stack(
                                      alignment: Alignment.center,
                                      clipBehavior: Clip.antiAlias,
                                      children: [
                                        Expanded(
                                          child: ClipRRect(
                                            child: Image.file(
                                              fit: BoxFit.fill,
                                              file!,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 50,
                                          bottom: 90,
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
                        ),
                        Container(
                          // padding: EdgeInsets.fromLTRB(14, 24, 14, 24),
                          width: 8,
                          height: 130,
                          decoration: const BoxDecoration(
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
                            child: file1 == null
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
                                                    value = 1;
                                                    takeFromCamera(context);
                                                  });
                                                },
                                                child: const Text(
                                                    'choose Image from camera'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  setState(() {
                                                    value = 1;
                                                    takeFromGallary(context);
                                                  });
                                                },
                                                child: const Text(
                                                    'choose Image from Gallery'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    icon: const Icon(Icons.add),
                                  )
                                : Stack(
                                    children: [
                                      Image.file(
                                        file1!,
                                        width: 130,
                                        height: 130,
                                      ),
                                      Positioned(
                                        left: 62,
                                        bottom: 62,
                                        child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              file1 = null;
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
                        Container(
                          // padding: EdgeInsets.fromLTRB(14, 24, 14, 24),
                          width: 8,
                          height: 130,
                          decoration: const BoxDecoration(
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
                            child: file2 == null
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
                                                    value = 2;
                                                    takeFromCamera(context);
                                                  });
                                                },
                                                child: const Text(
                                                    'choose Image from camera'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  setState(() {
                                                    value = 2;
                                                    takeFromGallary(context);
                                                  });
                                                },
                                                child: const Text(
                                                    'choose Image from Gallery'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    icon: const Icon(Icons.add),
                                  )
                                : Stack(
                                    children: [
                                      FittedBox(
                                        alignment: Alignment.center,
                                        fit: BoxFit.cover,
                                        child: Image.file(
                                          file2!,
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
                                              file2 = null;
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
                        Container(
                          // padding: EdgeInsets.fromLTRB(14, 24, 14, 24),
                          width: 8,
                          height: 130,
                          decoration: const BoxDecoration(
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
                            child: file3 == null
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
                                                    value = 3;
                                                    takeFromCamera(context);
                                                  });
                                                },
                                                child: const Text(
                                                    'choose Image from camera'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  setState(() {
                                                    value = 3;
                                                    takeFromGallary(context);
                                                  });
                                                },
                                                child: const Text(
                                                    'choose Image from Gallery'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    icon: const Icon(Icons.add),
                                  )
                                : Stack(
                                    children: [
                                      FittedBox(
                                        alignment: Alignment.center,
                                        fit: BoxFit.cover,
                                        child: Image.file(
                                          file3!,
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
                                              file3 = null;
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
                        Container(
                          // padding: EdgeInsets.fromLTRB(14, 24, 14, 24),
                          width: 8,
                          height: 130,
                          decoration: const BoxDecoration(
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
                            child: file4 == null
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
                                                    value = 4;
                                                    takeFromCamera(context);
                                                  });
                                                },
                                                child: const Text(
                                                    'choose Image from camera'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  setState(() {
                                                    value = 4;
                                                    takeFromGallary(context);
                                                  });
                                                },
                                                child: const Text(
                                                    'choose Image from Gallery'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    icon: const Icon(Icons.add),
                                  )
                                : Stack(
                                    children: [
                                      FittedBox(
                                        alignment: Alignment.center,
                                        fit: BoxFit.cover,
                                        child: Image.file(
                                          file4!,
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
                                              file4 = null;
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
                        Container(
                          // padding: EdgeInsets.fromLTRB(14, 24, 14, 24),
                          width: 8,
                          height: 130,
                          decoration: const BoxDecoration(
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
                            child: file5 == null
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
                                                    value = 5;
                                                    takeFromCamera(context);
                                                  });
                                                },
                                                child: const Text(
                                                    'choose Image from camera'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  setState(() {
                                                    value = 5;
                                                    takeFromGallary(context);
                                                  });
                                                },
                                                child: const Text(
                                                    'choose Image from Gallery'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    icon: const Icon(Icons.add),
                                  )
                                : Stack(
                                    children: [
                                      Image.file(
                                        file5!,
                                        width: 100,
                                        height: 100,
                                      ),
                                      Positioned(
                                        child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              file5 = null;
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
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Загружено 1 из 6 фотографий',
                    style: TextStyle(
                        color: Color(0xFF696868),
                        fontWeight: FontWeight.w500,
                        fontSize: 13),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Вы сможете загрузить фотографии позже.',
                    style: TextStyle(
                        color: Color(0xFFC3C3C3),
                        fontWeight: FontWeight.w400,
                        fontSize: 13),
                  ),
                  const SizedBox(
                    height: 70,
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
            ),
          ],
        ),
      ),
    );
  }
}
