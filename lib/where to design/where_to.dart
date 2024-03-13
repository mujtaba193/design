import 'package:design/where%20to%20design/user_main2.dart';
import 'package:design/where%20to%20design/users_model/user_model.dart';
import 'package:flutter/material.dart';

class WhereTo extends StatefulWidget {
  late List<UsersModel>? usersd;
  WhereTo({
    Key? key,
    this.usersd,
  }) : super(key: key);

  @override
  State<WhereTo> createState() => _WhereToState();
}

class _WhereToState extends State<WhereTo> {
  TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  double timeValue = 1.0;
  double timeValue2 = 1.0;
  List<UsersModel> newUsersd = [];

  DateTime userTimeNow1 = DateTime.now().toLocal();
  DateTime userTimeNow2 = DateTime.now().toLocal();

  DateTime date = DateTime.now().toLocal();
  TimeOfDay userTime = TimeOfDay.now();
  TimeOfDay userTime1 = TimeOfDay.now();
  Future datePicker() async {
    DateTime? dateTime = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime.now(),
        lastDate: DateTime(3030));
    if (dateTime == null) return;
    setState(() {
      date = dateTime;
    });
    final TimeOfDay? timeOfDay =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (timeOfDay != null) {
      setState(() {
        userTime = timeOfDay;
      });
    }
  }

  // new =======================================>
  dateTimePicker() async {
    DateTime? dateTime = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime.now(),
        lastDate: DateTime(3030));

    setState(() {
      if (dateTime != null) {
        userTimeNow1 = dateTime;
      }
    });

    TimeOfDay? timeOfDay =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (timeOfDay != null) {
      setState(() {
        userTimeNow1 = userTimeNow1
            .add(Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute));
        userTimeNow2 = userTimeNow1.add(Duration(hours: 1));
      });
    }
  }

  filterUsers() {
    if (widget.usersd != null) {
      for (var variable in widget.usersd!) {
        if ((userTimeNow2.isBefore(variable.bookedStartTime) ||
            userTimeNow1.isAfter(variable.bookedFinishTime))) {
          newUsersd.add(variable);
        }
      }
    }
  }

  @override
  void initState() {
    userTime1 = userTime1.replacing(hour: userTime1.hour + 1);
    userTimeNow2 = userTimeNow1.add(Duration(hours: 1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: Container(
          margin: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 0.1),
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  // offset: Offset(4.0, 4.0),
                  blurRadius: 10,
                  spreadRadius: 2),
            ],
          ),
          child: CloseButton(
            color: Colors.black,
            onPressed: () {},
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.height / 48),
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.height / 48,
                    top: MediaQuery.of(context).size.height / 10,
                    right: MediaQuery.of(context).size.height / 48),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          // offset: Offset(4.0, 4.0),
                          blurRadius: 10,
                          spreadRadius: 2),
                    ]),
                width: MediaQuery.of(context).size.width / 1.1,
                height: MediaQuery.of(context).size.height / 2.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: const Text(
                        'Where to?',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 70,
                    ),
                    Form(
                      child: Container(
                        height: 50,
                        child: TextField(
                          key: _formKey,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontWeight: FontWeight.w700,
                              fontSize: 18),
                          decoration: InputDecoration(
                            hintText: 'Search destinations',
                            hintStyle: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontWeight: FontWeight.w700),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          controller: _controller,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  datePicker();
                },
                child: Container(
                  margin:
                      EdgeInsets.all(MediaQuery.of(context).size.height / 48),
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width / 30),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.7),
                      ),
                      borderRadius: BorderRadius.circular(8)),
                  height: 50,
                  child: Row(
                    children: [
                      Text(
                        'when',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${date.day}-${date.month}-${date.year} (${userTime.hour}:${userTime.minute})",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(MediaQuery.of(context).size.height / 48),
                padding: EdgeInsets.all(MediaQuery.of(context).size.width / 30),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.7),
                    ),
                    borderRadius: BorderRadius.circular(8)),
                height: 50,
                child: Row(
                  children: [
                    Text(
                      'Duration',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        setState(() {
                          int hour = userTime1.hour;
                          int minute = userTime1.minute;
                          if (timeValue > 1.0) {
                            timeValue = timeValue - 0.5;
                            if (userTime1.minute >= 30) {
                              userTime1 = userTime1.replacing(
                                  minute: userTime1.minute - 30);
                            } else {
                              if (hour < 1 && minute < 30) {
                                hour = 24;
                              }
                              userTime1 = userTime1.replacing(
                                  hour: hour - 1,
                                  minute: userTime1.minute + 30);
                            }
                          }
                        });
                      },
                      child: Icon(
                        Icons.remove,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      " $timeValue ",
                      style: TextStyle(color: Colors.black),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          int hour = userTime1.hour;
                          timeValue = timeValue + 0.5;
                          if (userTime1.minute + 30 < 60) {
                            userTime1 = userTime1.replacing(
                                minute: userTime1.minute + 30);
                          } else {
                            int x = 60 - userTime1.minute;
                            int i = 30 - x;
                            if (hour < 23) {
                              hour = hour;
                              userTime1 = userTime1.replacing(
                                  hour: hour + 1, minute: i);
                            } else {
                              hour = -1;
                              userTime1 = userTime1.replacing(
                                  hour: hour + 1, minute: i);
                            }
                          }
                        });
                      },
                      child: Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${userTime.hour}:${userTime.minute}',
                    style: TextStyle(color: Colors.black, fontSize: 26),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 20,
                  ),
                  Text(
                    'to',
                    style: TextStyle(color: Colors.black, fontSize: 26),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 20,
                  ),
                  Text(
                    '${userTime1.hour < 10 ? '0${userTime1.hour}' : userTime1.hour}:${userTime1.minute < 10 ? '0${userTime1.minute}' : userTime1.minute}',
                    style: TextStyle(color: Colors.black, fontSize: 26),
                  )
                ],
              ),
              // ********************************************************************************************
              // Here is the new task ***********************************************************************

              InkWell(
                onTap: () {
                  dateTimePicker();
                },
                child: Container(
                  margin:
                      EdgeInsets.all(MediaQuery.of(context).size.height / 48),
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width / 30),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.7),
                      ),
                      borderRadius: BorderRadius.circular(8)),
                  height: 50,
                  child: Row(
                    children: [
                      Text(
                        'when',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${userTimeNow1.day}-${userTimeNow1.month}-${userTimeNow1.year} (${userTimeNow1.hour}:${userTimeNow1.minute})",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(MediaQuery.of(context).size.height / 48),
                padding: EdgeInsets.all(MediaQuery.of(context).size.width / 30),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.7),
                    ),
                    borderRadius: BorderRadius.circular(8)),
                height: 50,
                child: Row(
                  children: [
                    Text(
                      'Duration',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (timeValue2 > 1.0) {
                            timeValue2 = timeValue2 - 0.5;
                            userTimeNow2 = userTimeNow2.subtract(
                              Duration(minutes: 30),
                            );
                          }
                        });
                      },
                      child: Icon(
                        Icons.remove,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      " $timeValue2 ",
                      style: TextStyle(color: Colors.black),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          timeValue2 = timeValue2 + 0.5;
                          userTimeNow2 = userTimeNow2.add(
                            Duration(minutes: 30),
                          );
                        });
                      },
                      child: Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${userTimeNow1.hour < 10 ? '0${userTimeNow1.hour}' : userTimeNow1.hour}:${userTimeNow1.minute < 10 ? '0${userTimeNow1.minute}' : userTimeNow1.minute}',
                    style: TextStyle(color: Colors.black, fontSize: 26),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 20,
                  ),
                  Text(
                    'to',
                    style: TextStyle(color: Colors.black, fontSize: 26),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 20,
                  ),
                  Text(
                    '${userTimeNow2.hour < 10 ? '0${userTimeNow2.hour}' : userTimeNow2.hour}:${userTimeNow2.minute < 10 ? '0${userTimeNow2.minute}' : userTimeNow2.minute}',
                    style: TextStyle(color: Colors.black, fontSize: 26),
                  )
                ],
              ),
              InkWell(
                onTap: () async {
                  await filterUsers();
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return UsersMainPage2(
                        newUsersd: newUsersd,
                      );
                    }),
                  );
                },
                child: Container(
                  margin:
                      EdgeInsets.all(MediaQuery.of(context).size.height / 48),
                  height: 50,
                  width: MediaQuery.of(context).size.width / 1.1,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.7),
                    ),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          // offset: Offset(4.0, 4.0),
                          blurRadius: 10,
                          spreadRadius: 2),
                    ],
                  ),
                  child: Center(
                      child: Text(
                    'Search',
                    style: TextStyle(color: Colors.black),
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
