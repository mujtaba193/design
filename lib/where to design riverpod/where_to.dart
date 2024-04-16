import 'package:design/where%20to%20design%20riverpod/home_page.dart';
import 'package:design/where%20to%20design%20riverpod/show_information.dart';
import 'package:design/where%20to%20design%20riverpod/users_model/boat_model.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class WhereTo extends StatefulWidget {
  // late List<UsersModel>? usersd;
  List<BoatModelRiverPod>? boatList;
  final BoatModelRiverPod? boatinfo;
  bool? isSearch;
  WhereTo({
    Key? key,
    this.boatList,
    this.isSearch,
    this.boatinfo,
    //this.usersd,
  }) : super(key: key);

  @override
  State<WhereTo> createState() => _WhereToState();
}
// ".MainApplication"

class _WhereToState extends State<WhereTo> {
  TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  double timeValue = 1.0;
  double timeValue2 = 1.0;
  List<BoatModelRiverPod> newUsersd = [];
  List<BoatModelRiverPod> newBoatList = [];

  DateTime userTimeNow1 = DateTime.now().toLocal();
  DateTime userTimeNow2 = DateTime.now().toLocal();
  /////////////////////////city///////////////////////////
  List<String> cityList = [];
  String? selectedCity;

  DateTime date = DateTime.now().toLocal();

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
    if (widget.isSearch == false) {
      cheackBookTime();
    }
  }

  /* filterUsers() {
    if (widget.usersd != null) {
      for (var variable in widget.usersd!) {
        if ((userTimeNow2.isBefore(variable.bookedStartTime) ||
            userTimeNow1.isAfter(variable.bookedFinishTime))) {
          newUsersd.add(variable);
        }
      }
    }
  } */
  // List<BoatModel>? boatList;

  @override
  void initState() {
    userTimeNow2 = userTimeNow1.add(Duration(hours: 1));
    filterCities();
    super.initState();
  }

//////////////////////////function to show the list of cities ////////////////
  void _showCityPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: ListView.builder(
            itemCount: cityList.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(cityList[index]),
                onTap: () {
                  setState(() {
                    selectedCity = cityList[index];
                  });
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }

  filterCities() {
    if (widget.boatList != null) {
      for (var varr in widget.boatList!) {
        String city = varr.city;
        if (!cityList.contains(city)) {
          cityList.add(city);
        }
      }
      print(cityList);
    }
  }

  cheackBookTime() {
    if (userTimeNow2.isBefore(widget.boatinfo!.bookedStartTime) == false &&
        userTimeNow1.isAfter(widget.boatinfo!.bookedFinishTime) == false) {
      showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: Container(
                  height: 50,
                  child: Center(
                      child: Text('Already booked pls select another time'))),
            );
          });
    }
  }

  filterBoat() {
    if (widget.boatList != null) {
      for (var variablee in widget.boatList!) {
        if ((userTimeNow2.isBefore(variablee.bookedStartTime) ||
                userTimeNow1.isAfter(variablee.bookedFinishTime)) &&
            variablee.city == selectedCity) {
          newBoatList.add(variablee);
        }
      }
    }
  }

/*    varia.city == selectedCity  */
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: Container(
          margin: EdgeInsets.only(top: 10),
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
            borderRadius: BorderRadius.circular(50),
          ),
          child: CloseButton(
            onPressed: () {
              Navigator.pop(context);
            },
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
                  borderRadius: BorderRadius.circular(20),
                ),
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
                          //color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 70,
                    ),
                    InkWell(
                      onTap: () {
                        _showCityPicker(context);
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 1.1,
                        decoration: BoxDecoration(
                          color: Color(0xFF714BD8).withOpacity(0.3),
                          //Colors.grey.withOpacity(0.5),
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
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            '${widget.isSearch == false ? widget.boatinfo!.city : selectedCity == null ? 'Chose destination ' : selectedCity}',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white60.withOpacity(0.6),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
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
                      borderRadius: BorderRadius.circular(8)),
                  height: 50,
                  child: Row(
                    children: [
                      Text(
                        'when',
                        style: TextStyle(),
                      ),
                      Spacer(),
                      Text(
                        "${userTimeNow1.day}-${userTimeNow1.month}-${userTimeNow1.year} (${userTimeNow1.hour}:${userTimeNow1.minute})",
                        style: TextStyle(),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(MediaQuery.of(context).size.height / 48),
                padding: EdgeInsets.all(MediaQuery.of(context).size.width / 30),
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
                    borderRadius: BorderRadius.circular(8)),
                height: 50,
                child: Row(
                  children: [
                    Text(
                      'Duration',
                      style: TextStyle(),
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
                        //color: Colors.black,
                      ),
                    ),
                    Text(
                      " $timeValue2 ",
                      style: TextStyle(//color: Colors.black,
                          ),
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
                        //color: Colors.black,
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
                    style: TextStyle(
                      //color: Colors.black,
                      fontSize: 26,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 20,
                  ),
                  Text(
                    'to',
                    style: TextStyle(
                        //color: Colors.black,
                        fontSize: 26),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 20,
                  ),
                  Text(
                    '${userTimeNow2.hour < 10 ? '0${userTimeNow2.hour}' : userTimeNow2.hour}:${userTimeNow2.minute < 10 ? '0${userTimeNow2.minute}' : userTimeNow2.minute}',
                    style: TextStyle(
                        //color: Colors.black,
                        fontSize: 26),
                  )
                ],
              ),
              InkWell(
                onTap: () async {
                  if (widget.isSearch == false) {
                    if ((userTimeNow2
                                .isBefore(widget.boatinfo!.bookedStartTime) ==
                            false &&
                        userTimeNow1
                                .isAfter(widget.boatinfo!.bookedFinishTime) ==
                            false)) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: Container(
                                  height: 50,
                                  child: const Center(
                                      child: Text(
                                          'Already booked pls select another time'))),
                            );
                          });
                    } else {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return ShowInformation(
                            boatinfo: widget.boatinfo,
                            userTimeNow1: userTimeNow1,
                            userTimeNow2: userTimeNow2,
                            isBooked: false);
                      }));
                    }
                  } else {
                    await filterBoat();
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return HomePageProv(
                          newBoatList: newBoatList,
                          userTimeNow1: userTimeNow1,
                          userTimeNow2: userTimeNow2,
                        );
                      }),
                    );
                  }
                },
                child: Container(
                  margin:
                      EdgeInsets.all(MediaQuery.of(context).size.height / 48),
                  height: 50,
                  width: MediaQuery.of(context).size.width / 1.1,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF8942BC),
                        Color(0xFF5831F7),
                        Color(0xFF5731F8),
                        Color(0xFF00C2C2),
                      ],
                    ),
                    //color: Colors.grey.withOpacity(0.5),
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
                    borderRadius: BorderRadius.circular(8),
                    /* boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          // offset: Offset(4.0, 4.0),
                          blurRadius: 10,
                          spreadRadius: 2),
                    ],*/
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
